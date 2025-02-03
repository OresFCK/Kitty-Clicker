extends Node

signal cat_clicked  

@onready var label = get_node("../Label")

var points = 0
var click_strength = 1

func _ready():
	connect("cat_clicked", Callable(self, "_on_cat_clicked")) 

func emit_click():
	emit_signal("cat_clicked")  

func _on_pressed() -> void:
	points += click_strength
	update_ui()
	
func update_ui():
	label.update_score(points)
