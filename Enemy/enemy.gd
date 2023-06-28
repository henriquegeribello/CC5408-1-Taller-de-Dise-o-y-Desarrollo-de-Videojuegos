extends CharacterBody2D
class_name Enemy

@export var movement_speed = 30.0

@export var hp = 1

@onready var player = get_tree().get_first_node_in_group("player") 
@onready var EnemySpawner = get_parent()

@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")

func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction*movement_speed
	move_and_slide()

func _on_hurt_box_hurt(damage):
	hp -= damage
	if hp <= 0:
		EnemySpawner.number_of_enemies_in_la_pantalla-=1
		EnemySpawner.number_of_enemies_slayed_by_the_player+=1
		
		player.change_deadEnemiesCounter(EnemySpawner.number_of_enemies_slayed_by_the_player)
		
		print( EnemySpawner.number_of_enemies_slayed_by_the_player)
		queue_free()


