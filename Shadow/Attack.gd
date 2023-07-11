extends Node2D

var attack_spawner = preload("res://Shadow/genericShadowProjectileSpawner.tscn")

var init_attacks = []
var attack_event_timeline = []
var attack_timestamps = []

var available_enemies = [] 

func _ready():
	var timeline = load("res://Shadow/Timelines/last_game_timeline.tres")
	init_attacks = timeline.init_attacks
	attack_event_timeline = timeline.events
	attack_timestamps = timeline.timestamps
	for attack in init_attacks:
		var spawner = attack_spawner.instantiate()
		print(attack)
		spawner.projectile = load(attack)
		spawner.enemyDetect = %rayEnemyDetector
		add_child(spawner)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	


func _on_body_entered(body):
	if body is Enemy and not available_enemies.has(body):
		available_enemies.append(body)


func _on_body_exited(body):
	if body in available_enemies:
		available_enemies.erase(body)
		

func get_closest_enemy():
	return %rayEnemyDetector.get_closest_enemy()
