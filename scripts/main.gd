extends Node

var points = 0
var click_strength = 1
var clicks_per_second = 0
var prestige_points = 0  
var prestige_multiplier = 1.0 
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

				label.update_score(round(points))
				sps_label.update_score_per_second(clicks_per_second)
				
			file.close()

func calculate_prestige_points():
	return int(floor(sqrt(points / 1000000)))  

func prestige():
	var gained_prestige = calculate_prestige_points()
	if gained_prestige > 0:
		prestige_points += gained_prestige
		prestige_multiplier = 1.0 + (prestige_points * 0.01)  # 1% bonus per prestige point

		points = 0
		click_strength = 1
		clicks_per_second = 0
		Upgrades.reset_upgrades()

		save_game()
		label.update_score(points)
		sps_label.update_score_per_second(clicks_per_second)
		print("Prestiged! You now have " + str(prestige_points) + " prestige points.")
	else:
		print("Not enough points to prestige!")

func get_effective_click_strength():
	return float(click_strength) * float(prestige_multiplier)

func get_effective_cps():
	return float(clicks_per_second) * float(prestige_multiplier)
