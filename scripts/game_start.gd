extends Node

func _ready():
	$MainButton.pressed.connect(_on_main_button_pressed)
	$OptionsButton.pressed.connect(_on_options_button_pressed)

func _on_main_button_pressed():
	get_tree().change_scene_to_file("res://scenes/Main.tscn")

func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://scenes/Options.tscn")
