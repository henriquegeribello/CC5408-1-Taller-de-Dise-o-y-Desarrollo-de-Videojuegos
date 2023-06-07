extends Node2D

enum {simple, homing, fixed}
var projectile_node = preload("res://Attacks/genericProjectile.tscn")
var projectile : Projectile
var ammo : int
var level = 1

var available_enemies = []

var ray_number = 16
var closest_enemy : Vector2

var shadow_mov = Vector2(1, 0)

@onready var shadow = get_tree().get_first_node_in_group("shadow")
@onready var rootScene = get_tree().get_first_node_in_group("root")
@onready var reloadTimer = $reloadTimer
@onready var attackTimer = $attackTimer
@onready var enemyDetect = $enemyDetection 

# Called when the node enters the scene tree for the first time.
func _ready():
	ammo = projectile.base_ammo
	attackTimer.wait_time = projectile.fire_rate
	reloadTimer.wait_time = projectile.reload_speed
	attackTimer.start()
	
func _process(delta):
	#global_position = get_parent().global_position
	pass

func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	closest_enemy = Vector2(100, 100)
	for i in ray_number:
		var ray_target = Vector2(0, 1).rotated(360/ray_number)
		var ray = PhysicsRayQueryParameters2D.create(global_position, global_position + ray_target)
		ray.exclude = [self]
		var result = space_state.intersect_ray(ray)
		if result:
			if (global_position.distance_squared_to(result["position"]) < global_position.distance_squared_to(closest_enemy)):
				closest_enemy = result.position
				print(closest_enemy)
	

func _on_attack_timer_timeout():
	print("Shadow attack")
	if ammo > 0:
		if not available_enemies.is_empty():
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
	var bullet = projectile_node.instantiate()
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
	bullet.collision_rot = projectile.collision_rot
	set_target(bullet)
	rootScene.add_child(bullet)

func set_target(bullet):
	match bullet.type:
		simple:
			if shadow.mov != Vector2.ZERO:
				shadow_mov = shadow.mov.normalized()
			bullet.target_pos = shadow_mov
		homing:
			if (available_enemies.size()):
				var en = get_closest_enemy()
				bullet.enemy_target = en
		fixed:
			bullet.mov = projectile.mov

func get_closest_enemy():
	var ret = available_enemies[0]
	var dist = ret.global_position.distance_squared_to(shadow.global_position)
	for en in available_enemies:
		if en.global_position.distance_squared_to(shadow.global_position) < dist:
			ret = en
			dist = en.global_position.distance_squared_to(shadow.global_position)
	return ret


func _on_body_entered(body):
	if body is Enemy and not available_enemies.has(body):
		available_enemies.append(body)


func _on_body_exited(body):
	if body in available_enemies:
		available_enemies.erase(body)
