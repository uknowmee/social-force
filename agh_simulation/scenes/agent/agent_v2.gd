extends CharacterBody2D
class_name AgentV2

@export var randomTargetOffset := false
@export var radius := 22.023
@export var targets: Array[NodePath] = []
@export var maximumVelocity := 70.0
@export var weight := 1.0
@export var maximumRaycastAngle := 180
@export var raycastPlacementDensity := 25
@export var raycastDistance := 150
@export var relaxationTime := 1.5
@export var rotationSpeed := 0.1

@onready var sprite: Sprite2D = $Sprite2D
@onready var raycastContainer: Node2D = $Raycasts
@onready var rays: Array[RayCast2D] = []

var frontmost_ray: RayCast2D
var modulateColor: Variant
var reached_target := false
var desired_direction := 0.0
var desired_velocity := Vector2(0, 0)

@onready var targetNodes: Array[Node2D] = _getTargetNodes()

var currentTarget: Node2D = null
var spawner: StringName = "None"
signal agent_reached_target(agent: Node, currentTarget: Node, time: int)

@onready var nav : NavigationAgent2D = $NavigationAgent2D

func _ready() -> void:
	if targetNodes.is_empty():
		push_warning("No targets specified!")
		return

	randomize()
	_set_radius()

	if modulateColor != null:
		sprite.modulate = modulateColor
	else:
		modulateColor = Color(randf(), randf(), randf())

	_generate_raycasts()
	best_ray = rays[0]
	
	currentTarget = targetNodes.pop_front()
	nav.target_position = currentTarget.position
	
	if currentTarget != null:
		look_at(_get_tmp_target())

	set_motion_mode(MOTION_MODE_FLOATING)


func _process(_dt: float) -> void:
	if not currentTarget:
		push_warning("Agent has no target")
		set_process(false)
		return

	if _has_reached_target():
		emit_signal(
			"agent_reached_target",
			spawner,
			name,
			currentTarget,
			targetNodes.size() == 0,
			Time.get_ticks_msec()
		)
		if targetNodes.size() != 0:
			currentTarget = targetNodes.pop_front()
			nav.target_position = currentTarget.position
		else:
			queue_free()
	
var best_ray: RayCast2D
var cached_heuristics := {}
var heuristic_cache_timer := 0.0
const HEURISTIC_CACHE_UPDATE_INTERVAL := 0.1

var speed_cache: float = 0
var speed_cache_timer := 0.0
const SPEED_CACHE_UPDATE_INTERVAL := 0.3

func _physics_process(_delta: float) -> void:
	heuristic_cache_timer += _delta
	speed_cache_timer += _delta
	
	if heuristic_cache_timer >= HEURISTIC_CACHE_UPDATE_INTERVAL or cached_heuristics.size() == 0:
		heuristic_cache_timer = 0.0
		_update_heuristics()

		best_ray = rays[0]
		var best_distance: float = cached_heuristics[best_ray]
		for i in range(1, rays.size()):
			var ray := rays[i]
			var distance: float = cached_heuristics[ray]
			if distance > best_distance:
				best_distance = distance
				best_ray = ray

	desired_direction = best_ray.rotation + rotation
	rotation = lerp_angle(rotation, desired_direction, rotationSpeed)
	
	if speed_cache_timer >= SPEED_CACHE_UPDATE_INTERVAL:
		speed_cache_timer = 0.0
		speed_cache = _get_desired_speed()
	
	velocity = velocity.lerp(Vector2(speed_cache, 0).rotated(rotation), 0.2)
	move_and_slide()


func _get_desired_speed() -> float:
	var dist := _raycast_distance_to_collision(frontmost_ray) / relaxationTime
	return min(maximumVelocity, dist)


# d(alpha)
func _update_heuristics() -> void:
	var tmp_target := _get_tmp_target()
	var dir_to_target := tmp_target.angle_to_point(position)

	for ray in rays:
		var dist := _raycast_distance_to_collision(ray)
		var global_angle := ray.rotation + rotation
		var penalty := 2 * raycastDistance * dist * cos(dir_to_target - global_angle)
		cached_heuristics[ray] = sqrt(raycastDistance * raycastDistance + dist * dist - penalty)


# f(alpha)
func _raycast_distance_to_collision(ray: RayCast2D) -> float:
	if ray.is_colliding():
		return position.distance_to(ray.get_collision_point())
	else:
		return raycastDistance


func _set_radius() -> void:
	var shapeNode: CollisionShape2D = get_node("CollisionShape2D")
	var shape: CircleShape2D = shapeNode.shape
	var oldCollisionRadius := shape.radius
	var oldSpriteScale := 2*oldCollisionRadius/128
	var newScale := radius / oldCollisionRadius

	shapeNode.scale = Vector2(newScale, newScale)
	sprite.scale = oldSpriteScale * Vector2(newScale, newScale)


func _has_reached_target() -> bool:
	if targetNodes.size() > 0:
		return radius * 2 + 50 > position.distance_to(currentTarget.position)
	else:
		return radius * 2 > position.distance_to(currentTarget.position)


func _generate_raycasts() -> void:
	for child: RayCast2D in raycastContainer.get_children():
		rays.append(child)
	for step: int in range(0, (maximumRaycastAngle / 2 + 1), raycastPlacementDensity):
		for direction: int in ([1] if step == 0 else [1, -1]):
			var rc: RayCast2D = RayCast2D.new()
			rc.target_position = Vector2(raycastDistance, 0)
			rc.rotation = deg_to_rad(step * direction)
			rc.enabled = true
			raycastContainer.add_child(rc)
			rays.append(rc)
			if step * direction == 0:
				frontmost_ray = rc


func _getTargetNodes() -> Array[Node2D]:
	if targets == null || targets.size() == 0:
		return []

	var nodes: Array[Node2D] = []
	for targetNode in targets:
		nodes.append(get_node(targetNode))
	return nodes


func _get_tmp_target() -> Vector2:
	return nav.get_next_path_position()
