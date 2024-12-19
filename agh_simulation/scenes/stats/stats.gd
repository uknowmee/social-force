extends Node

@onready var phyfcountLabel: Label = $Control/MarginContainer/VBoxContainer/PhyFrameCount
@onready var fpsLabel: Label = $Control/MarginContainer/VBoxContainer/FPS
@onready var processfcountLabel: Label = $Control/MarginContainer/VBoxContainer/ProcessFrameCount
@onready var enginetimeLabel: Label = $Control/MarginContainer/VBoxContainer/EngineTime
@onready var readyTimestamp := Time.get_unix_time_from_system() * 1000


func _process(_dt: float) -> void:
	phyfcountLabel.text = "Physics frames count: " + str(Engine.get_physics_frames())
	processfcountLabel.text = "Process frames count: " + str(Engine.get_process_frames())
	fpsLabel.text = "FPS: " + str(Engine.get_frames_per_second())
	var ticks := Time.get_ticks_msec();
	enginetimeLabel.text = "Engine ticks (ms): " + str(ticks);
