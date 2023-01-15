extends Area2D
var agentScene = preload("../agent/Agent.tscn")

export var enabled = true
export var amount = 8
export(NodePath) var target = null
export var spawn_per_second = 0; 
export var randomize_raycast_angle = 30;
export var ranzomize_radius = 2.5;
export var randomize_raycast_distance = 20;
export var randomize_max_speed = 30;
export var randomize_relaxation_time = 0.5;
export var randomize_rotation_speed = 0.05;

onready var agentContainer = $"../Agents"
onready var collisionShape = get_node("CollisionShape2D")
onready var target_node =  get_node(self.target);
var shape = null
var modulateColor = null

func _ready():
	if not target:
		push_warning("No target specified!")
		return
	
	randomize()
	var shape_owners = self.get_shape_owners()
	self.shape = shape_owner_get_shape(shape_owners[0], 0)
	
	# random color modulate
	modulateColor = Color(randf(), randf(), randf())
	if enabled:
		for _i in range(amount):
			spawn_child()

func spawn_child():
	var instance = agentScene.instance()
	instance.spawner = self.name
	
	instance.position = get_random_pos_inside_shape()
	instance.target = target_node;
	instance.modulateColor = modulateColor;
	instance.raycastDistance = instance.raycastDistance + rand_range(-randomize_raycast_distance, randomize_raycast_distance);
	instance.maximumRaycastAngle = instance.maximumRaycastAngle + rand_range(-randomize_raycast_angle, randomize_raycast_angle);
	instance.radius = instance.radius + rand_range(-ranzomize_radius, ranzomize_radius);
	instance.maximumVelocity = instance.maximumVelocity + rand_range(-randomize_max_speed, randomize_max_speed);
	instance.relaxationTime = instance.relaxationTime + rand_range(-randomize_relaxation_time, randomize_relaxation_time);
	instance.rotationSpeed = instance.rotationSpeed + rand_range(-randomize_rotation_speed, randomize_rotation_speed)
	self.agentContainer.add_child(instance)

func get_random_pos_inside_shape():
	var center = self.collisionShape.position + self.position
	var extents = shape.extents
	var rng_pos = Vector2(
		#rand_range(center.x - extents.x, center.x + extents.x),
		center.x,
		rand_range(center.y - extents.y, center.y + extents.y)
	)
	return rng_pos

func _on_Timer_timeout():
	for _i in range(spawn_per_second):
		spawn_child()
