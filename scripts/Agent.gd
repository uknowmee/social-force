extends KinematicBody2D

export var mass = 1.0
export var radius = 35.0

# TODO: calibrate those
export var maximumVelocity = 100.0
export var R_0 = 400

onready var walls = get_tree().root.get_node("Simulation/Walls").get_children()

var desiredVelocity = Vector2(0, 0)
var velocity = Vector2(0, 0)
var reached_target = false
var target = null

func _ready():
	randomize()
	self.set_radius(radius)

func _process(_dt):
	if not target:
		return
	var obst = self.get_obstacle_force()
	self.desiredVelocity = obst + self.get_desired_force()
	self.velocity = self.move_and_slide(self.desiredVelocity)
	self.look_at(self.position + velocity)
	if has_reached_target():
		print("Agent reached target!")
		queue_free()

func set_radius(rd):
	self.radius = rd
	var shape = get_node("CollisionShape2D").shape
	shape.set_radius(self.radius)

func get_desired_force():
	return self.maximumVelocity * self.position.direction_to(self.target.position)

func get_obstacle_force():
	var result = Vector2(0, 0)
	for line in self.walls:
		for i in range(1, len(line.points)):
			var start = line.points[i-1]
			var end = line.points[i]
			var d = force_to_line_segment(start, end)
			result = result - d
	return result

# https://stackoverflow.com/a/1501725
func force_to_line_segment(start, end):
	var l2 = (end-start).length_squared()
	if l2 == 0:
		return self.position.distance_to(start)
	var t = clamp(
		(self.position - start).dot(end - start) / l2,
		0, 1
	)
	var projection = start + t * (end - start)
	var exponential = exp(-self.position.distance_to(projection) / R_0)
	return exponential * self.position.direction_to(projection) * 100

func has_reached_target():
	return self.radius > self.position.distance_to(target.position);
