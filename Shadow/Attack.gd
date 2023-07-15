extends Node2D

var attack_spawner = preload("res://Shadow/genericShadowProjectileSpawner.tscn")

var projectiles = {
	"ice_spear":load("res://Attacks/Projectiles/iceSpear.tres"),
	"lightning_bird":load("res://Attacks/Projectiles/lightningBird.tres"),
	"iron_slash":load("res://Attacks/Projectiles/ironSlash.tres")
}

var spawners := {}

var init_attacks = []
var attack_event_timeline = []
var attack_timestamps = []

var available_enemies = [] 

@onready var eventTimer = %eventTimer

func _ready():
	var timeline = load("res://Shadow/Timelines/last_game_timeline.tres")
	init_attacks = timeline.init_attacks
	attack_event_timeline = timeline.events
	attack_timestamps = timeline.timestamps
	for attack in init_attacks:
		var spawner = attack_spawner.instantiate()
		spawner.projectile = load(attack)
		spawner.enemyDetect = %rayEnemyDetector
		add_child(spawner)
		spawners[attack] = spawner
	
	if not attack_timestamps.is_empty():
		eventTimer.wait_time = attack_timestamps.pop_front()/1000
		eventTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func upgrade_attack(attack):
	projectiles[attack] = projectiles[attack].nextlvl
	return spawners[attack].upgrade_attack()

func _on_body_entered(body):
	if body is Enemy and not available_enemies.has(body):
		available_enemies.append(body)


func _on_body_exited(body):
	if body in available_enemies:
		available_enemies.erase(body)
		

func get_closest_enemy():
	return %rayEnemyDetector.get_closest_enemy()


func _on_event_timer_timeout():
	if not attack_event_timeline.is_empty():
		var prevtime = %eventTimer.wait_time
		var attack = attack_event_timeline.pop_front()
		upgrade_attack(attack)
		%eventTimer.start((attack_timestamps.pop_front() - prevtime)/1000)
	else:
		%eventTimer.stop()
