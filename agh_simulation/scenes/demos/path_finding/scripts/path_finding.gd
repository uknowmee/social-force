extends Area2D

@onready var nav : NavigationAgent2D = $NavigationAgent2D
var finished := false

func _ready() -> void:
	nav.target_position = Vector2(2960, 590)


func _physics_process(delta: float) -> void:
	if not finished:	
		var direction : Vector2 = (nav.get_next_path_position() - global_position).normalized()
		translate(direction)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		nav.target_position = get_global_mouse_position()
		finished = false


func _on_navigation_agent_2d_navigation_finished() -> void:
	finished = true
