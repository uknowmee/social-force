extends KinematicBody2D

export var mass = 1.0
export var radius = 35.0

export var maximumVelocity = 100.0
export var weight = 1.0
export var maximumRaycastAngle = 120;
export var raycastDistance = 100;
export var relaxationTime = 1.5;

onready var raycast = $RayCast2D;
onready var sprite = $Sprite;

var velocity = Vector2(0, 0)
var reached_target = false
var target = null
var modulateColor = null

var desired_direction = 0;
var desired_velocity = Vector2(0,0);

func _ready():
	randomize()
	self.set_radius()
	raycast.cast_to = Vector2(raycastDistance, 0)
	sprite.modulate = modulateColor;

func _process(_dt):
	if not target:
		push_warning("Agent has no target");
		set_process(false);
		return
	
	# construct desired velocity from distance and angle
	desired_direction = get_desired_direction()
	desired_velocity = Vector2(get_desired_speed(), 0);
	
	rotation_degrees = rotation_degrees + desired_direction;
	
	if has_reached_target():
		print("Agent reached target!")
		queue_free()

func _physics_process(delta):
	velocity = move_and_slide(desired_velocity.rotated(rotation))

func get_desired_speed():
	var dist = raycast_distance_at_angle(0) / relaxationTime;
	return min(maximumVelocity, dist);

func get_desired_direction():
	var best_angle = null;
	var best_distance = null;
	for step in range(0, maximumRaycastAngle / 2, 2):
		for direction in ([1] if step == 0 else [1, -1]):
			var dir = step * direction
			var distance = cognitive_heuristic(dir);
			if best_distance == null or distance > best_distance:
				best_distance = distance;
				best_angle = dir;
	return best_angle

# d(alpha)
func cognitive_heuristic(angle):
	var dist_to_collision = raycast_distance_at_angle(angle);
	var direction_to_target = position.angle_to_point(target.position);
	var global_angle = deg2rad(angle) + rotation;
	var penalty = 2 * raycastDistance * dist_to_collision * cos(direction_to_target - global_angle)
	return pow(raycastDistance, 2) + pow(dist_to_collision, 2) - penalty;

# f(alpha)
func raycast_distance_at_angle(angle):
	raycast.rotation_degrees = angle;
	raycast.force_raycast_update();
	if raycast.is_colliding():
		return position.distance_to(raycast.get_collision_point());
	else:
		return raycastDistance;

func set_radius():
	var shape = get_node("CollisionShape2D").shape
	shape.set_radius(self.radius)
	# original sprite size is 128x128, scale it to fit the radius
	sprite.scale = Vector2(self.radius / 128, self.radius / 128)

func has_reached_target():
	return self.radius > self.position.distance_to(target.position);
