extends Node

var points = 0
var click_strength = 1
var clicks_per_second = 0
var save_path = "user://savegame.save"
var timer : Timer

@onready var label = get_node("ScoreLabel")
@onready var sps_label = get_node('ScorePerSecondLabel')

func _ready():
	load_game()
	if not timer:
		start_autosave()

func start_autosave():
	timer = Timer.new()
	timer.wait_time = 1.0
	timer.autostart = true
	timer.connect("timeout", Callable(self, "save_game"))
	add_child(timer)

func save_game():
	var data = {
		"points": points,
		"click_strength": click_strength,
		"clicks_per_second": clicks_per_second,
		"upgrades": Upgrades.save_upgrades()
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
				clicks_per_second = data.get("clicks_per_second", 0)

				var saved_upgrades = data.get("upgrades", [])
				if saved_upgrades.size() > 0:
					Upgrades.upgrades = saved_upgrades

				label.update_score(points)

			file.close()
