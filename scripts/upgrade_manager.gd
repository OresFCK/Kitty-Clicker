# upgrade_manager.gd
extends Node

@onready var button_container = $VBoxContainer
@onready var ui_label = get_node('ScoreLabel')
@onready var sps_label = get_node('ScorePerSecondLabel')

var upgrades = [] 
var timer: Timer
var buttons = []

func _ready():
	load_upgrades()
	generate_upgrade_buttons()

	timer = Timer.new()
	timer.wait_time = 1.0
	timer.one_shot = false
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	add_child(timer)
	update_timer()

func load_upgrades():
	upgrades = Upgrades.get_upgrades() 

func generate_upgrade_buttons():
	for upgrade in upgrades:
		var button = Button.new()
		button.text = upgrade["name"] + " - " + str(upgrade["price"]) + " Coins (Level " + str(upgrade["level"]) + ")"

		button.connect("pressed", Callable(self, "_on_upgrade_button_pressed").bind(upgrade))

		button_container.add_child(button)
		buttons.append(button)

func _on_upgrade_button_pressed(upgrade):
	if Main.points >= upgrade["price"]:
		Main.points -= upgrade["price"]
		ui_label.update_score(Main.points)

		if "click_strength" in upgrade:
			Main.click_strength += upgrade["click_strength"]
		if "cps" in upgrade:
			Main.clicks_per_second += upgrade["cps"]

		upgrade["level"] += 1
		upgrade["price"] = int(upgrade["price"] * 1.15)  

		update_button_text(upgrade)

		update_timer()
	else:
		print("Not enough coins to purchase " + upgrade["name"] + "!")

func update_button_text(upgrade):
	for i in range(len(upgrades)):
		if upgrades[i] == upgrade:
			var button = buttons[i]
			button.text = upgrade["name"] + " - " + str(upgrade["price"]) + " Coins (Level " + str(upgrade["level"]) + ")"
			break

func update_timer():
	if Main.clicks_per_second > 0:
		timer.wait_time = 1.0 / Main.clicks_per_second
		sps_label.update_score_per_second(Main.clicks_per_second)
		if not timer.is_stopped():
			timer.stop()
		timer.start()
	else:
		timer.stop()

func _on_timer_timeout():
	Main.points += Main.click_strength
	ui_label.update_score(Main.points)
	update_timer()
