extends Node2D

var agentContainer = null
var sceneName = ""
var logs = {}
var record = {}

func _ready():
	sceneName = self.filename.split("/")[-1].split(".")[0]
	
	agentContainer = $"Agents"
	logs["agents"] = []
	logs["chairs"] = []

func update_logs(spawner, agentName, target, isLastTarget, time) -> void:
	record.clear()
	
	record["agent"] = agentName
	record["elapsedTime"] = time
	record["isLastTarget"] = isLastTarget
	record["position"] = target.position
	record["spawner"] = spawner
	record["targetName"] = target.name

	logs["agents"].append(record.duplicate())
	
	if (agentContainer.get_children().size() == 1 && isLastTarget):
		logs["fullTime"] = Time.get_ticks_msec()
		save_logs()

func update_logs_chairs(time) -> void:
	logs["chairs"].append(time)

func save_logs():
	var path = "user://" + sceneName.to_lower() + ".json"
	
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_line(to_json(logs))
	file.close()
	
	print("Logs saved")
