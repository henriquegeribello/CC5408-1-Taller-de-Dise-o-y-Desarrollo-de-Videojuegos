extends MarginContainer

@onready var resume = %Resume
@onready var retry = %Retry
@onready var main_menu = %MainMenu

#@export var main_menu_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	resume.pressed.connect(_on_resume_pressed)
	retry.pressed.connect(_on_retry_pressed)
	main_menu.pressed.connect(_on_main_menu_pressed)
	hide()
	
func _input(event):
	if event.is_action_pressed("pause"):
		show()
		get_tree().paused = true

func _on_resume_pressed():
	hide()
	get_tree().paused = false

func _on_retry_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func _on_main_menu_pressed():
#	get_tree().change_scene_to_packed(main_menu_scene)
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	get_tree().paused = false
