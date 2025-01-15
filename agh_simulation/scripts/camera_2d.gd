extends Camera2D

@export var offset_value := Vector2(576, 324)
@export var zoom_value := Vector2.ONE

var target_position := Vector2.ZERO
var dragging := false
var drag_start := Vector2.ZERO
var change := Vector2(0.01, 0.01)


func _ready() -> void:
	offset = offset_value
	zoom = zoom_value


func _process(_delta: float) -> void:
	if dragging:
		var mouse_position := get_global_mouse_position()
		var drag_delta := mouse_position - drag_start
		target_position -= drag_delta
		drag_start = mouse_position

	position = position.lerp(target_position, 0.1)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event := event as InputEventMouseButton

		if mouse_event.button_index == MOUSE_BUTTON_LEFT:
			if mouse_event.pressed:
				dragging = true
				drag_start = get_global_mouse_position()
			else:
				dragging = false

		if mouse_event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom -= change

		if mouse_event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom += change
