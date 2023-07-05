extends Node2D

enum {simple, homing, fixed, melee}
var projectile_node = preload("res://Attacks/genericProjectile.tscn")

var simple_projectile_node = preload("res://Attacks/simpleProjectile.tscn")
var homing_projectile_node = preload("res://Attacks/homingProjectile.tscn")
var melee_projectile_node = preload("res://Attacks/meleeProjectile.tscn")

var projectile : Projectile
var ammo : int
var level = 1

var available_enemies = []
var enemyDetect : EnemyDetector
var player_mov = Vector2(1, 0)

@onready var player = get_tree().get_first_node_in_group("player")
@onready var rootScene = get_tree().get_first_node_in_group("root")
@onready var reloadTimer = $reloadTimer
@onready var attackTimer = $attackTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	ammo = projectile.base_ammo
	attackTimer.wait_time = projectile.fire_rate
	reloadTimer.wait_time = projectile.reload_speed
	attackTimer.start()
	
func _process(delta):
	#global_position = get_parent().global_position
	pass


func _on_attack_timer_timeout():
	if ammo > 0:
		if check_for_enemies():
			bullet_init()
			ammo -= 1
		attackTimer.start()
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
	var bullet : Node2D
	match projectile.type:
		simple:
			bullet = simple_projectile_node.instantiate()
		homing:
			bullet = homing_projectile_node.instantiate()
		melee:
			bullet = melee_projectile_node.instantiate()
		_:
			bullet = projectile_node.intantiate()
		
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
	bullet.collision = projectile.collision
	bullet.collision_shift = projectile.collision_shift
	bullet.collision_rot = projectile.collision_rot
	set_target(bullet)
	rootScene.add_child(bullet)

func set_target(bullet):
	match bullet.type:
		homing:
			var enmy = get_closest_enemy()
			if enmy != null:
				bullet.enemy_target = enmy
		fixed:
			bullet.mov = projectile.mov
		_:
			if player.velocity != Vector2.ZERO:
				player_mov = player.velocity.normalized()
			bullet.target_pos = player_mov

func get_closest_enemy():
	return enemyDetect.get_closest_enemy()
	
func check_for_enemies():
	return enemyDetect.check_for_enemies()

