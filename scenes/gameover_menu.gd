extends MarginContainer

@onready var retry = %RetryOfGameOver 
@onready var main_menu = %MainMenuOfGameOver 

# Called when the node enters the scene tree for the first time.
func _ready():
	retry.pressed.connect(_on_retry_pressed)
	main_menu.pressed.connect(_on_main_menu_pressed)
	hide()# Replace with function body.

func show_menu():
	show()
	get_tree().paused = true

func _on_retry_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func _on_main_menu_pressed():
#	get_tree().change_scene_to_packed(main_menu_scene)
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	get_tree().paused = false
