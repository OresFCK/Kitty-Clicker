extends Node

@onready var ui_label = get_node("../ScoreLabel")
@onready var sps_label = get_node('../ScorePerSecondLabel')

var is_clicking = false
var timer: Timer

func _ready():
	timer = Timer.new()
	timer.wait_time = 1.0  
	timer.one_shot = false
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	add_child(timer)
	timer.start()

func _on_pressed() -> void:
	Main.points += Main.click_strength
	ui_label.update_score(Main.points)
	
	if !is_clicking: 
		is_clicking = true
		update_sps_label()

func update_sps_label() -> void:
	if is_clicking:
		var total_per_second = Main.click_strength + Main.clicks_per_second
		sps_label.update_score_per_second(total_per_second)
	else:
		sps_label.update_score_per_second(Main.clicks_per_second)

func _on_timer_timeout() -> void:
	if is_clicking: 
		is_clicking = false
		update_sps_label()
