extends Area2D

export var amount = 10
export(NodePath) var target = null
export var spawn_per_second = 0; 
var agentScene = preload("res://Agent.tscn")

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
	for _i in range(amount):
		spawn_child()

func spawn_child():
	var instance = agentScene.instance()
	instance.position = get_random_pos_inside_shape()
	instance.target = target_node;
	instance.modulateColor = modulateColor;
	self.agentContainer.add_child(instance)

func get_random_pos_inside_shape():
	var center = self.collisionShape.position + self.position
	var extents = shape.extents
	var rng_pos = Vector2(
		rand_range(center.x - extents.x, center.x + extents.x),
		rand_range(center.y - extents.y, center.y + extents.y)
	)
	return rng_pos

func _on_Timer_timeout():
	for i in range(spawn_per_second):
		spawn_child()
