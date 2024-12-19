extends Camera2D

@export var scroll_speed := 300
@export var zoom_speed := 0.01
@export var max_zoom := 0.03
@export var min_zoom :=  0.01

var target_position := Vector2.ZERO
var dragging := false
var drag_start := Vector2.ZERO
var change := Vector2(0.02, 0.02)

func _ready():
	offset = (get_viewport() as Window).size / 2
	zoom = Vector2.ONE

func _process(delta):
	handle_movement(delta)

func handle_movement(_delta):
	if dragging:
		var mouse_position := get_global_mouse_position()
		var drag_delta := mouse_position - drag_start
		target_position -= drag_delta
		drag_start = mouse_position

	position = position.lerp(target_position, 0.1)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				dragging = true
				drag_start = get_global_mouse_position()
			else:
				dragging = false
		
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom -= change
			
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom += change
