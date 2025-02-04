extends Node

@onready var label = get_node("../ScoreLabel")

func _on_pressed() -> void:
	Main.points += Main.click_strength
	update_ui()
	
func update_ui():
	label.update_score(Main.points)
