extends Node2D


var projectile_node = preload("res://Attacks/genericProjectile.tscn")
var projectile : Projectile
var ammo : int
var level = 1

@onready var player = get_tree().get_first_node_in_group("player")
@onready var rootScene = get_tree().get_first_node_in_group("root")
@onready var reloadTimer = %reloadTimer
@onready var attackTimer = %attackTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	ammo = projectile.base_ammo
	attackTimer.wait_time = projectile.fire_rate
	reloadTimer.wait_time = projectile.reload_time
	reloadTimer.start()





func _on_attack_timer_timeout():
	if ammo > 0:
		var bullet = projectile_node.instantiate()
		bullet.type = projectile.type
		bullet.level = level
		bullet.hp = projectile.hp
		bullet.speed = projectile.speed
		bullet.damage = projectile.damage
		bullet.flight_time = projectile.flight_time
		bullet.position = player.position
		
		
