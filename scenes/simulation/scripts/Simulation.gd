extends Node2D

var agentContainer = null
var sceneName = ""
var logs = {}
var record = {}

func _ready():
	sceneName = self.filename.split("/")[-1].split(".")[0]
	
	agentContainer = $"Agents"
	logs["agents"] = []

func update_logs(spawner, agentName, target, time) -> void:
	record.clear()
	
	record["agent"] = agentName
	record["elapsedTime"] = time
	record["position"] = target.position
	record["spawner"] = spawner
	record["targetName"] = target.name

	logs["agents"].append(record)
	
	if (agentContainer.get_children().size() == 1):
		logs["fullTime"] = Time.get_ticks_usec()
		save_logs()

func save_logs():
	var path = "user://" + sceneName.to_lower() + ".json"
	
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_line(to_json(logs))
	file.close()
	
	print("Logs saved")
