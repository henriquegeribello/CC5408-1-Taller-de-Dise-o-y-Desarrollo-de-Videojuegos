extends MarginContainer

@onready var start = %Start
@onready var exit = %Exit

@export var main_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	start.pressed.connect(_on_start_pressed)
	exit.pressed.connect(_on_exit_pressed)
	
func _on_start_pressed():
	get_tree().change_scene_to_packed(main_scene)
	
func _on_exit_pressed():
	get_tree().quit()

