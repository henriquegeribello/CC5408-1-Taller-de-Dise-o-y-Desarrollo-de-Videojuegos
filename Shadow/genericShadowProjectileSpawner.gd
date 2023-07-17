extends Node2D

enum {simple, homing, fixed, melee}
var projectile_node = preload("res://Attacks/genericProjectile.tscn")
var projectile : Projectile
var ammo : int
var level = 1

var available_enemies = []
var enemyDetect : EnemyDetector

var ray_number = 16
var closest_enemy : Enemy
var rays = []
var shadow_mov = Vector2(1, 0)

var simple_projectile_node = preload("res://Attacks/simpleProjectile.tscn")
var homing_projectile_node = preload("res://Attacks/homingProjectile.tscn")
var melee_projectile_node = preload("res://Attacks/meleeProjectile.tscn")

@onready var shadow = get_tree().get_first_node_in_group("Shadow")
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
	if shadow.mov != Vector2.ZERO:
		shadow_mov = shadow.mov.normalized()

func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	var closest_col = Vector2(100, 100)
	var dir_vec = Vector2(0, 100)
	for i in ray_number:
		var ray_target = dir_vec
		dir_vec = dir_vec.rotated(deg_to_rad(360.0/ray_number))
		var ray = PhysicsRayQueryParameters2D.create(global_position, global_position + ray_target)
		ray.exclude = [self, get_parent(), get_parent().get_parent()]
		var result = space_state.intersect_ray(ray)
		if result:
			if (global_position.distance_squared_to(result["position"]) < global_position.distance_squared_to(closest_col)):
				if result.collider.is_in_group("Enemy"):
					closest_enemy = result.collider

func _on_attack_timer_timeout():
	if ammo > 0:
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
	var bullet : genericProjectile
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
	bullet.position = shadow.position
	bullet.sprite = projectile.sprite
	bullet.hframes = projectile.hframes
	bullet.vframes = projectile.vframes
	bullet.sprite_rotation = projectile.rotation
	bullet.collision = projectile.collision
	bullet.collision_shift = projectile.collision_shift
	bullet.collision_rot = projectile.collision_rot
	bullet.attack_size = projectile.attack_size
	bullet.attacker = shadow
	set_target(bullet)
	rootScene.add_child(bullet)

func set_target(bullet):
	match bullet.type:
		homing:
			var enm = get_closest_enemy()
			if enm != null:
				bullet.enemy_target = enm
		fixed:
			bullet.mov = projectile.mov
		_:
			if shadow.mov != Vector2.ZERO:
				shadow_mov = shadow.mov.normalized()
			bullet.target_pos = shadow_mov

func get_closest_enemy():
	return enemyDetect.get_closest_enemy()

func upgrade_attack():
	if level == projectile.max_level:
		return -1
	projectile = projectile.nextlvl
	level += 1
	return 1
