extends KinematicBody2D

export var mass = 1.0
export var radius = 35.0

export var maximumVelocity = 50.0
export var weight = 1.0
export var maximumRaycastAngle = 20;
export var raycastDistance = 150;
export var relaxationTime = 1;

onready var raycasts = $Raycasts.get_children();

var velocity = Vector2(0, 0)
var reached_target = false
var target = null

func _ready():
	randomize()
	self.set_radius(radius)

func _process(dt):
	if not target:
		push_warning("Agent has no target");
		set_process(false);
		return
	
	
	if has_reached_target():
		print("Agent reached target!")
		queue_free()

#alpha_des(t)
func get_desired_direction():
	pass

# f(alpha)
func get_closest_visible_obstacle():
	var closest_body = null;
	var distance_to_body = raycastDistance;
	for raycast in raycasts:
		if raycast.is_colliding():
			var dist = position.distance_to(raycast.get_collision_point());
			if (dist < distance_to_body):
				closest_body = raycast.get_collider();
				distance_to_body = dist;
	return [closest_body, distance_to_body]

func set_radius(rd):
	self.radius = rd
	var shape = get_node("CollisionShape2D").shape
	shape.set_radius(self.radius)

func has_reached_target():
	return self.radius > self.position.distance_to(target.position);
