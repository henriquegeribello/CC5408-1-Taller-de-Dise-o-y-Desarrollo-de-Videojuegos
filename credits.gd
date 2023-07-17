extends MarginContainer

@onready var back = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer2/Back

# Called when the node enters the scene tree for the first time.
func _ready():
	back.pressed.connect(_on_back_pressed) # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
