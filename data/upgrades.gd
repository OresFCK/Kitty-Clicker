extends Node

var upgrades = [
	{"id": 1, "name": "uia cat", "price": 15, "click_strength": 1, "level": 1},
	{"id": 2, "name": "chippy chappa cat", "price": 100, "cps": 0.1, "level": 0},
	{"id": 3, "name": "mega chippy cat", "price": 500, "cps": 0.5, "level": 0},
	{"id": 4, "name": "ultra chippa cat", "price": 2000, "cps": 1.0, "level": 0},
	{"id": 5, "name": "ultimate clicker cat", "price": 5000, "cps": 2.0, "level": 0}
]

func get_upgrades():
	return upgrades

func save_upgrades():
	var saved_upgrades = []
	for upgrade in upgrades:
		saved_upgrades.append({
			"id": upgrade.id,
			"name": upgrade.name,
			"price": upgrade.price,
			"cps": upgrade.get("cps", 0), 
			"click_strength": upgrade.get("click_strength", 0),
			"level": upgrade.level
		})
	return saved_upgrades

func load_upgrades():
	if FileAccess.file_exists("user://savegame.save"):
		var file = FileAccess.open("user://savegame.save", FileAccess.READ)
		if file:
			var content = file.get_as_text()
			var data = JSON.parse_string(content)
			if typeof(data) == TYPE_DICTIONARY:
				upgrades = data.get("upgrades", upgrades)  
			file.close()

func reset_upgrades():
	for upgrade in upgrades:
		upgrade["level"] = 0
