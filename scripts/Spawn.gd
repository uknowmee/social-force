extends Area2D

export var amount = 10
export(NodePath) var target = null
var agentScene = preload("res://Agent.tscn")

onready var agentContainer = $"../Agents"
onready var collisionShape = $Shape
var shape = null

func _ready():
	if not target:
		push_warning("No target specified!")
		return
	
	randomize()
	var shape_owners = self.get_shape_owners()
	self.shape = shape_owner_get_shape(shape_owners[0], 0)
	
	var target_node = get_node(self.target)
	for i in range(amount):
		print(target_node)
		var instance = agentScene.instance()
		instance.position = get_random_pos_inside_shape()
		instance.target = target_node
		self.agentContainer.add_child(instance)
		
func get_random_pos_inside_shape():
	var center = self.collisionShape.position + self.position
	var extents = shape.extents
	print(center)
	print(extents)
	var rng_pos = Vector2(
		rand_range(center.x - extents.x, center.x + extents.x),
		rand_range(center.y - extents.y, center.y + extents.y)
	)
	print(rng_pos)
	return rng_pos
