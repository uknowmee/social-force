extends Node2D

var agentContainer = null
var logs = {}
var record = {}
var logsFolder = "logs"
var dirSeparator = "/"

func _ready():
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
	var dir = Directory.new()
	if (!dir.file_exists(logsFolder)):
		dir.make_dir(logsFolder)
	
	var file = File.new()
	file.open(logsFolder + dirSeparator + self.name.to_lower() + ".json", File.WRITE)
	file.store_line(to_json(logs))
	file.close()
	
	print(logs)
	print("Logs saved")
