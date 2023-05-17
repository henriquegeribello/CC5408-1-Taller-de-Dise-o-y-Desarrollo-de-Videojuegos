extends Node
var iceSpear = preload("res://Attacks/Projectiles/iceSpear.tres")

@onready var player = get_tree().get_first_node_in_group("player")
@onready var reloadTimer = $reloadTimer
@onready var attackTimer = $attackTimer
@onready var rootScene = get_tree().get_first_node_in_group("root")

#Stats
var ammo = 1
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
	attackTimer.wait_time = 1
	reloadTimer.wait_time = 2
	attackTimer.start()
	reloadTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_reload_timer_timeout():
	ammo += base_amo
	if attackTimer.is_stopped():
		attackTimer.start()


func _on_attack_timer_timeout():
	print("ATTACK!")
	print(ammo)
	if ammo > 0:
		var iceSpearAttack = iceSpear.scene.instantiate()
		iceSpearAttack.position = player.position 
		iceSpearAttack.target = get_random_target() + iceSpearAttack.position
		iceSpearAttack.level = level
		rootScene.add_child(iceSpearAttack)
		ammo -= 1
		if ammo > 0:
			attackTimer.start()
	else:
		attackTimer.stop()
		reloadTimer.start()

func get_random_target():
	var trgt = Vector2(randf(), randf()).normalized()
	print(trgt)
	return trgt

