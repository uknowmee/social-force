extends CharacterBody2D

@export var randomTargetOffset := false
@export var radius := 22.023
@export var targets: Array[NodePath] = []
@export var maximumVelocity := 70.0
@export var weight := 1.0
@export var maximumRaycastAngle := 180
@export var raycastPlacementDensity := 18
@export var raycastDistance := 150
@export var relaxationTime := 1.5
@export var rotationSpeed := 0.1

@onready var sprite: Sprite2D = $Sprite2D
@onready var raycastContainer: Node2D = $Raycasts
@onready var rays: Array[RayCast2D] = []

var frontmost_ray     =  null
var modulateColor     =  null
var reached_target    := false
var desired_direction := 0.0
var desired_velocity  := Vector2(0, 0)

@onready var targetNodes: Array[Node] = getTargetNodes();

var currentTarget: Node = null
var spawner             = null
signal agent_reached_target(agent, currentTarget, time)


func _ready() -> void:
	if targetNodes.is_empty():
		push_warning("No targets specified!")
		return

	randomize()
	set_radius()

	if modulateColor != null:
		sprite.modulate = modulateColor;
	else:
		modulateColor = Color(randf(), randf(), randf())

	generate_raycasts()

	currentTarget = targetNodes.pop_front()
	if currentTarget != null:
		look_at(currentTarget.position);

	set_motion_mode(MOTION_MODE_FLOATING)


func _process(_dt) -> void:
	if not currentTarget:
		push_warning("Agent has no target");
		set_process(false);
		return

	desired_direction = get_desired_direction()
	rotation = lerp(rotation, desired_direction, rotationSpeed)
	desired_velocity = Vector2(get_desired_speed(), 0).rotated(rotation);

	if has_reached_target():
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
		else:
			queue_free()


func _physics_process(_delta: float) -> void:
	velocity = lerp(velocity, desired_velocity, 0.2)
	move_and_slide()


func get_desired_speed() -> float:
	var dist := raycast_distance_to_collision(frontmost_ray) / relaxationTime;
	return min(maximumVelocity, dist);


func get_desired_direction() -> float:
	var best_ray: RayCast2D;
	var best_distance: float;
	for ray in rays:
		var distance := cognitive_heuristic(ray);
		if best_distance == null or distance > best_distance:
			best_distance = distance;
			best_ray = ray;
	return best_ray.rotation + rotation;


# d(alpha)
func cognitive_heuristic(ray) -> float:
	var dist_to_collision := raycast_distance_to_collision(ray);
	var direction_to_target = currentTarget.position.angle_to_point(position);
	var global_angle = ray.rotation + rotation;
	var penalty: float = 2 * raycastDistance * dist_to_collision * cos(direction_to_target - global_angle)
	return sqrt(pow(raycastDistance, 2) + pow(dist_to_collision, 2) - penalty);


# f(alpha)
func raycast_distance_to_collision(raycast) -> float:
	if raycast.is_colliding():
		return position.distance_to(raycast.get_collision_point());
	else:
		return raycastDistance;


func set_radius():
	var shapeNode: CollisionShape2D = get_node("CollisionShape2D");
	var shape: CircleShape2D = shapeNode.shape;
	var oldCollisionRadius := shape.radius;
	var oldSpriteScale := 2*oldCollisionRadius/128;
	var newScale := radius / oldCollisionRadius;

	shapeNode.scale = Vector2(newScale, newScale);
	sprite.scale = oldSpriteScale * Vector2(newScale, newScale);


func has_reached_target() -> bool:
	if    targetNodes.size() > 0:
		return radius * 2 + 50 > position.distance_to(currentTarget.position);
	else:
		return radius * 2 > position.distance_to(currentTarget.position);


func generate_raycasts():
	for child: RayCast2D in raycastContainer.get_children():
		rays.append(child)
	for step: int in range(0, (maximumRaycastAngle / 2 + 1), raycastPlacementDensity):
		for direction: int in ([1] if step == 0 else [1, -1]):
			var rc: RayCast2D = RayCast2D.new();
			rc.target_position = Vector2(raycastDistance, 0)
			rc.rotation = deg_to_rad(step * direction);
			rc.enabled = true;
			raycastContainer.add_child(rc)
			rays.append(rc)
			if step * direction == 0:
				frontmost_ray = rc;


func getTargetNodes() -> Array[Node]:
	if targets == null || targets.size() == 0:
		return []

	var nodes: Array[Node] = []
	for targetNode in targets:
		nodes.append(get_node(targetNode))
	return nodes
