extends Area2D

enum {simple, homing, fixed}
var type = simple
var level = 1
var hp = 1
var speed = 100
var damage = 5
var kback_amount = 100
var attack_size = 1.0


var target_pos = Vector2.ZERO
var angle = Vector2.ZERO
var mov = Vector2.ZERO 

@onready var player = get_tree().get_first_node_in_group("player")
@onready var enemy_target = get_tree().get_first_node_in_group("enemy")

func _ready():
	print(target_pos)
	angle = global_position.direction_to(target_pos)
	rotation = angle.angle() + deg_to_rad(90)

	

func _physics_process(delta):
	match type:
		simple: 
			position += angle*speed*delta
		homing:
			position += global_position.direction_to(enemy_target.position)*speed*delta
		fixed:
			position += mov*speed*delta
	
func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		queue_free()


