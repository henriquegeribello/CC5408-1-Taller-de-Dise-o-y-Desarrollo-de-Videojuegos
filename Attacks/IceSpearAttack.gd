extends Node

var iceSpear = preload("res://Attacks/IceSpear.tscn")
var player = get_tree().get_first_node_in_group("player")

@onready var reloadTimer = get_node("%reloadTimer")
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
		reloadTimer.wait_time = attack_speed
		if reloadTimer.is_stopped():
			reloadTimer.start()



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_reload_timer_timeout():
	ammo += base_amo
	reloadTimer.start()


func _on_attack_timer_timeout():
	if ammo > 0:
		var iceSpearAttack = iceSpear.instantiate()
		iceSpearAttack.position = player.position 
		iceSpearAttack.target = get_random_target()
		iceSpearAttack.level = level
		add_child(iceSpearAttack)
		ammo -= 1
		if ammo > 0:
			attackTimer.start()
		else:
			attackTimer.stop()

func get_random_target():
	pass
