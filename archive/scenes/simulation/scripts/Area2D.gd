extends Area2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

signal left_chairs(time)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("left_chairs", get_tree().root.get_node("Simulation"), "update_logs_chairs")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func _on_Area2D_body_entered(body: Node) -> void:
	emit_signal("left_chairs", Time.get_ticks_msec())
