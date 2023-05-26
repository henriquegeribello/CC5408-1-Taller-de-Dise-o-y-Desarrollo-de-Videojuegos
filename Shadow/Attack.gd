extends Node2D

var attack_spawner = preload("res://Attacks/genericProjectileSpawner.tscn")

var init_attacks = []
var attack_event_timeline = []
var attack_timestamps = []

func _ready():
	for attack in init_attacks:
		var spawner = attack_spawner.instantiate()
		spawner.projectile = load(attack)
		add_child(spawner)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
