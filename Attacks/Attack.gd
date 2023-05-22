extends Node2D

var projectileSpawner = load("res://Attacks/genericProjectileSpawner.tscn")
var projectiles = {
	"ice_spear":load("res://Attacks/Projectiles/iceSpear.tres"),
	"lightning_bird":load("res://Attacks/Projectiles/lightningBird.tres")
}

var iceSpear : Node2D
var lightningBird : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	iceSpear = create_spawner("ice_spear")
	lightningBird = create_spawner("lightning_bird")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	# print(global_position)


func create_spawner(projectile_name):
	var ret = projectileSpawner.instantiate()
	ret.projectile = projectiles[projectile_name]
	add_child(ret)
	return ret
