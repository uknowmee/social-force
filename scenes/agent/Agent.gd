extends KinematicBody2D

export var randomTargetOffset = false;
export var radius = 35.0

export var maximumVelocity = 80.0
export var weight = 1.0
export var maximumRaycastAngle = 100;
export var raycastPlacementDensity = 2;
export var raycastDistance = 150;
export var relaxationTime = 2;
export var rotationSpeed = 0.05;

onready var sprite = $Sprite;
onready var raycastContainer = $Raycasts;
onready var rays = [];
var frontmost_ray = null;

var velocity = Vector2(0, 0)
var reached_target = false
var target = null
var modulateColor = null

var desired_direction = 0;
var desired_velocity = Vector2(0,0);

func _ready():
	randomize()
	#self.set_radius()
	sprite.modulate = modulateColor;
	generate_raycasts()
	look_at(target.position)

func _process(_dt):
	if not target:
		push_warning("Agent has no target");
		set_process(false);
		return
	
	desired_direction = get_desired_direction()
	rotation = lerp(rotation, desired_direction, rotationSpeed)
	desired_velocity = Vector2(get_desired_speed(), 0).rotated(rotation);
	
	if has_reached_target():
		print("Agent reached target!")
		queue_free()

func _physics_process(delta):
	velocity = lerp(velocity, desired_velocity, 0.235)
	velocity = move_and_slide(velocity)

func get_desired_speed():
	var dist = raycast_distance_to_collision(frontmost_ray) / relaxationTime;
	return min(maximumVelocity, dist);

func get_desired_direction():
	var best_ray = null;
	var best_distance = null;
	for ray in rays:
		var distance = cognitive_heuristic(ray);
		if best_distance == null or distance > best_distance:
			best_distance = distance;
			best_ray = ray;
	return best_ray.rotation + rotation;

# d(alpha)
func cognitive_heuristic(ray):
	var dist_to_collision = raycast_distance_to_collision(ray);
	var direction_to_target = position.angle_to_point(target.position);
	var global_angle = ray.rotation + rotation;
	var penalty = 2 * raycastDistance * dist_to_collision * cos(direction_to_target - global_angle)
	return sqrt(pow(raycastDistance, 2) + pow(dist_to_collision, 2) - penalty);

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
	return self.radius * 2 > self.position.distance_to(target.position);

func generate_raycasts():
	for child in raycastContainer.get_children():
		rays.append(child)
	for step in range(0, maximumRaycastAngle / 2, raycastPlacementDensity):
		for direction in ([1] if step == 0 else [1, -1]):
			var rc = RayCast2D.new();
			rc.cast_to = Vector2(raycastDistance, 0)
			rc.rotation = deg2rad(step * direction);
			rc.enabled = true;
			raycastContainer.add_child(rc)
			rays.append(rc)
			if step * direction == 0:
				frontmost_ray = rc;
