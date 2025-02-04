extends Node 

var upgrades = [
	{"id": 1, "name": "uia cat", "price": 15, "click_strength": 1},
	{"id": 2, "name": "chippy chappa cat", "price": 100, "cps": 0.1},
	{"id": 3, "name": "mega chippy cat", "price": 500, "cps": 0.5},
	{"id": 4, "name": "ultra chippa cat", "price": 2000, "cps": 1.0},
	{"id": 5, "name": "ultimate clicker cat", "price": 5000, "cps": 2.0}
]

func get_upgrades():
	return upgrades
