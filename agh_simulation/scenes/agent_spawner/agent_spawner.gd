extends Area2D

var agentScene = preload("../agent/agent.tscn")

@export var enabled = true
@export var amount = 8
@export var targets :Array[NodePath] = []
@export var spawn_per_second = 0
@export var randomize_raycast_angle = 30
@export var ranzomize_radius = 2.5
@export var randomize_raycast_distance = 20
@export var randomize_max_speed = 20
@export var randomize_relaxation_time = 0.2
@export var randomize_rotation_speed = 0.02

@onready var agentContainer = $"../../Agents"
@onready var collisionShape = get_node("CollisionShape2D")
var shape = null
var modulateColor = null
var time_since_last_spawn = 0.0


func _ready() -> void:
	if targets == null || targets.size() == 0:
		push_warning("No targets specified!")
		return
	
	randomize()
	var shape_owners = self.get_shape_owners()
	self.shape = shape_owner_get_shape(shape_owners[0], 0)
	
	modulateColor = Color(randf(), randf(), randf())
	if enabled:
		for _i in range(amount):
			spawn_child()

func spawn_child():
	var instance = agentScene.instantiate()
	instance.spawner = self.name
	
	instance.position = get_random_pos()
	instance.targets = targets;
	instance.modulateColor = modulateColor;
	instance.raycastDistance = instance.raycastDistance + randf_range(-randomize_raycast_distance, randomize_raycast_distance);
	instance.maximumRaycastAngle = instance.maximumRaycastAngle + randf_range(-randomize_raycast_angle, randomize_raycast_angle);
	instance.radius = instance.radius + randf_range(-ranzomize_radius, ranzomize_radius);
	instance.maximumVelocity = instance.maximumVelocity + randf_range(-randomize_max_speed, randomize_max_speed);
	instance.relaxationTime = instance.relaxationTime + randf_range(-randomize_relaxation_time, randomize_relaxation_time);
	instance.rotationSpeed = instance.rotationSpeed + randf_range(-randomize_rotation_speed, randomize_rotation_speed)
	self.agentContainer.add_child(instance)
	
func get_random_pos():
	var center = self.collisionShape.position + self.position
	var extents = shape.extents
	var rng_pos = Vector2(
		#rand_range(center.x - extents.x, center.x + extents.x),
		center.x,
		randf_range(center.y - extents.y, center.y + extents.y)
	)
	return rng_pos

func _process(delta: float) -> void:
	if spawn_per_second == 0:
		return
	
	time_since_last_spawn += delta
	var spawns = int(time_since_last_spawn * spawn_per_second)
	for _i in range(spawns):
		spawn_child()
	time_since_last_spawn -= spawns / spawn_per_second
