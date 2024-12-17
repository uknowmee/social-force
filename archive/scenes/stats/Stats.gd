extends Node

onready var phyfcountLabel = $FullRect/MarginContainer/VBoxContainer/PhyFrameCount;
onready var fpsLabel = $FullRect/MarginContainer/VBoxContainer/FPS;
onready var idlefcountLabel = $FullRect/MarginContainer/VBoxContainer/IdleFrameCount
onready var enginetimeLabel = $FullRect/MarginContainer/VBoxContainer/EngineTime

onready var readyTimestamp = Time.get_unix_time_from_system() * 1000

func _process(_dt: float) -> void:
	phyfcountLabel.text = "Physics frame count: " + str(Engine.get_physics_frames())
	idlefcountLabel.text = "Idle frame count: " + str(Engine.get_idle_frames())
	fpsLabel.text = "FPS: " + str(Engine.get_frames_per_second())
	var ticks = Time.get_ticks_msec()
	enginetimeLabel.text = "Engine ticks (ms): " + str(ticks)
