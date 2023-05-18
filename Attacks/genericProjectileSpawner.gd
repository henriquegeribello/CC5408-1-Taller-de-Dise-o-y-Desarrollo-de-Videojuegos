extends Node2D

enum {simple, homing, fixed}
var projectile_node = preload("res://Attacks/genericProjectile.tscn")
var projectile : Projectile
var ammo : int
var level = 1

var available_enemies = []
var player_mov : Vector2

@onready var player = get_tree().get_first_node_in_group("player")
@onready var rootScene = get_tree().get_first_node_in_group("root")
@onready var reloadTimer = $reloadTimer
@onready var attackTimer = $attackTimer
@onready var enemyDetect = $enemyDetection 

# Called when the node enters the scene tree for the first time.
func _ready():
	projectile = load("res://Attacks/Projectiles/lightningBird.tres")
	ammo = projectile.base_ammo
	attackTimer.wait_time = projectile.fire_rate
	reloadTimer.wait_time = projectile.reload_speed
	attackTimer.start()





func _on_attack_timer_timeout():
	if ammo > 0:
		if not available_enemies.is_empty():
			bullet_init()
	else:
		if not attackTimer.is_stopped():
			attackTimer.stop()
		reloadTimer.start()

func _on_reload_timer_timeout():
	ammo = projectile.base_ammo
	if not reloadTimer.is_stopped():
		reloadTimer.stop()
	attackTimer.start()

func bullet_init():
	var bullet = projectile_node.instantiate()
	bullet.type = projectile.type
	bullet.level = level
	bullet.hp = projectile.hp
	bullet.speed = projectile.speed
	bullet.damage = projectile.damage
	bullet.flight_time = projectile.flight_time
	bullet.position = player.position
	bullet.sprite = projectile.sprite
	bullet.hframes = projectile.hframes
	bullet.vframes = projectile.vframes
	bullet.sprite_rotation = projectile.rotation
	set_target(bullet)
	rootScene.add_child(bullet)

func set_target(bullet):
	match bullet.type:
		simple:
			if player.velocity != Vector2.ZERO:
				player_mov = player.velocity.normalized()
			bullet.target_pos = player_mov
		homing:
			if (available_enemies.size()):
				var en = get_closest_enemy()
				bullet.enemy_target = en
		fixed:
			bullet.mov = projectile.mov

func get_closest_enemy():
	var ret = available_enemies[0]
	var dist = ret.global_position.distance_squared_to(player.global_position)
	for en in available_enemies:
		if en.global_position.distance_squared_to(player.global_position) < dist:
			ret = en
			dist = en.global_position.distance_squared_to(player.global_position)
	return ret


func _on_body_entered(body):
	if body is Enemy and not available_enemies.has(body):
		available_enemies.append(body)


func _on_body_exited(body):
	if body in available_enemies:
		available_enemies.erase(body)



