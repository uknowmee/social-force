extends Node2D

var processTime: float = 0;
var phProcessTime: float = 0;

var processFrames: int = 0;
var phProcessFrames: int = 0;

var time_start: float = 0
var time_now: float = 0

func _ready():
	time_start = OS.get_unix_time()

func timeElapsed() -> float:
	time_now = OS.get_unix_time();
	var time_elapsed: float = time_now - time_start;
	return time_elapsed;

func _process(delta: float) -> void:
	processTime += delta;
	processFrames += 1;
	$lblProcess.text = "Process \n time: " + str(processTime) + "\nframes: " + str(processFrames);
	$lblFramesDrawnProcess.text = "Process (Godot) \nframes: " + str(Engine.get_frames_drawn()) + "\nfps: " + str(Engine.get_frames_per_second());
	$lblTimeProcess.text = "Time \nprocess: " + str(timeElapsed());

func _physics_process(delta: float) -> void:
	phProcessTime += delta;
	phProcessFrames += 1;
	$lblPhysicsProcess.text = "PhProcess \ntime: " + str(phProcessTime) + "\nframes: " + str(phProcessFrames);
	$lblFramesDrawnPhysicsProcess.text = "PhProcess (Godot) \nframes: " + str(Engine.get_frames_drawn()) + "\nfps: " + str(Engine.get_frames_per_second());
	$lblTimePhProcess.text = "\n\nphProcess: " + str(timeElapsed());
