extends Node2D

var projectileSpawner = load("res://Attacks/genericProjectileSpawner.tscn")
var projectiles = {
	"ice_spear":load("res://Attacks/Projectiles/iceSpear.tres"),
	"lightning_bird":load("res://Attacks/Projectiles/lightningBird.tres"),
	"iron_slash":load("res://Attacks/Projectiles/ironSlash.tres")
}

var iceSpear : Node2D
var lightningBird : Node2D
var ironSlash : Node2D
var ray_number = 16

# Called when the node enters the scene tree for the first time.
func _ready():
	#iceSpear = create_spawner("ice_spear")
	#lightningBird = create_spawner("lightning_bird")
	ironSlash = create_spawner("iron_slash")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func create_spawner(projectile_name):
	var ret = projectileSpawner.instantiate()
	ret.projectile = projectiles[projectile_name]
	ret.enemyDetect = %rayEnemyDetector
	add_child(ret)
	return ret

func get_closest_enemy():
	return %rayEnemyDetector.get_closest_enemy()
	

