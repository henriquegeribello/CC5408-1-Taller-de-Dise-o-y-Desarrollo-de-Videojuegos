extends Node

@onready var attackTimer = get_node("%attackTimer")

#Stats
var ammo = 0
var base_amo = 1
var attack_speed = 1.5
var level = 1

#Enemy related
var enemy_close = []

func attack():
	if (level > 0):
		attackTimer.wait_time = attack_speed
		if attackTimer.is_stopped():
			attackTimer.start()



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_reload_timer_timeout():
	ammo += base_amo
	attackTimer.start()
