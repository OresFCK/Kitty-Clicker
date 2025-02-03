extends Node

var points = 0
var click_strength = 1
var save_path = "user://savegame.save"  
@onready var label = get_node("/root/Node2D/Label")  

func _ready():
	load_game() 
	start_autosave()

func start_autosave():
	var timer = Timer.new()
	timer.wait_time = 1.0 
	timer.autostart = true
	timer.connect("timeout", Callable(self, "save_game"))
	add_child(timer)

func save_game():
	var data = {
		"points": points,
		"click_strength": click_strength
	}
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data, "\t")) 
		file.close()

func load_game():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		if file:
			var content = file.get_as_text()
			var data = JSON.parse_string(content)

			if typeof(data) == TYPE_DICTIONARY:  
				points = data.get("points", 0)
				click_strength = data.get("click_strength", 1)
				label.update_score(points)

			file.close()
