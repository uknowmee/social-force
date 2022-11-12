extends KinematicBody2D

export var mass = 1.0
export var radius = 35.0

export var maximumVelocity = 100.0
export var weight = 1.0
export var maximumRaycastAngle = 90;
export var raycastPlacementDensity = 3;
export var raycastDistance = 100;
export var relaxationTime = 1.5;

onready var sprite = $Sprite;
onready var raycastContainer = $Raycasts;

var velocity = Vector2(0, 0)
var reached_target = false
var target = null
var modulateColor = null

var desired_direction = 0;
var desired_velocity = Vector2(0,0);

func _ready():
	randomize()
	self.set_radius()
	sprite.modulate = modulateColor;
	generate_raycasts()

func _process(_dt):
	if not target:
		push_warning("Agent has no target");
		set_process(false);
		return
	
	desired_direction = get_desired_direction()
	desired_velocity = Vector2(get_desired_speed(), 0);
	
	rotation_degrees = rotation_degrees + desired_direction;
	
	if has_reached_target():
		print("Agent reached target!")
		queue_free()

func _physics_process(delta):
	velocity = move_and_slide(desired_velocity.rotated(rotation))

func get_desired_speed():
	var dist = raycast_distance_to_collision(raycastContainer.get_child(0)) / relaxationTime;
	return min(maximumVelocity, dist);

func get_desired_direction():
	var best_angle = null;
	var best_distance = null;
	for ray in raycastContainer.get_children():
		var distance = cognitive_heuristic(ray);
		if best_distance == null or distance > best_distance:
			best_distance = distance;
			best_angle = ray.rotation_degrees;
	return best_angle

# d(alpha)
func cognitive_heuristic(ray):
	var dist_to_collision = raycast_distance_to_collision(ray);
	var direction_to_target = position.angle_to_point(target.position);
	var global_angle = ray.rotation + rotation;
	var penalty = 2 * raycastDistance * dist_to_collision * cos(direction_to_target - global_angle)
	return pow(raycastDistance, 2) + pow(dist_to_collision, 2) - penalty;

# f(alpha)
func raycast_distance_to_collision(raycast):
	if raycast.is_colliding():
		return position.distance_to(raycast.get_collision_point());
	else:
		return raycastDistance;

func set_radius():
	var shape = get_node("CollisionShape2D").shape
	shape.set_radius(self.radius)
	sprite.scale = Vector2(self.radius / 128, self.radius / 128)

func has_reached_target():
	return self.radius > self.position.distance_to(target.position);

func generate_raycasts():
	for step in range(0, maximumRaycastAngle / 2, raycastPlacementDensity):
		for direction in ([1] if step == 0 else [1, -1]):
			var rc = RayCast2D.new();
			rc.cast_to = Vector2(raycastDistance, 0)
			rc.rotation_degrees = step * direction;
			rc.enabled = true;
			raycastContainer.add_child(rc)
