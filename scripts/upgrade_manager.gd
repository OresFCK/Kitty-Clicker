extends Node

@onready var button_container = $VBoxContainer 
var upgrades = [] 

func _ready():
	load_upgrades()
	generate_upgrade_buttons()

func load_upgrades():
	var upgrade_data = load("res://data/upgrades.gd").new() 
	upgrades = upgrade_data.get_upgrades()  

func generate_upgrade_buttons():
	for upgrade in upgrades:
		var button = Button.new()
		button.text = upgrade["name"] + " - " + str(upgrade["price"]) + " Coins"
		
		# Use Callable to pass arguments to the connected method
		button.connect("pressed", Callable(self, "_on_upgrade_button_pressed").bind(upgrade))
		
		button_container.add_child(button)

# Function to handle the button press
func _on_upgrade_button_pressed(upgrade):
	print("Upgrade clicked: " + upgrade["name"])
	# Add your logic to handle the upgrade here, e.g., apply the upgrade, deduct coins, etc.
