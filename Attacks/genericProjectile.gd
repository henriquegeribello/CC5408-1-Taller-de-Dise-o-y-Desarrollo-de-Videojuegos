extends Node2D

# Mechanic handling parameters
enum {simple, homing, fixed}
var type = simple
var level = 1
var hp = 1
var speed = 100
var damage = 5
var kback_amount = 100
var attack_size = 1.0
var flight_time = 10


var target_pos = Vector2.ZERO
var angle = Vector2.ZERO
var mov = Vector2.ZERO 
var enemy_target : Enemy

# Sprite params
var sprite = load("res://assets/attacks/IceVFX 1 Repeatable.png")
var hframes = 8
var vframes = 1
var sprite_rotation = 0
var frame = 0

@onready var player = get_tree().get_first_node_in_group("player")
@onready var flightTimer = $flightTimer


func _ready():
	$Sprite2D.texture = sprite
	$Sprite2D.hframes = hframes
	$Sprite2D.vframes = vframes
	$Sprite2D.rotation = sprite_rotation
	rotate(get_angle_to(target_pos + position))
	flightTimer.wait_time = flight_time
	flightTimer.start()

func _process(delta):
	$Sprite2D.set_frame(int(frame))
	frame += 0.2
	if frame>hframes:
		frame = int(frame)%hframes

func _physics_process(delta):
	match type:
		simple: 
			position += target_pos*speed*delta
		homing:
			if is_instance_valid(enemy_target):
				rotate(get_angle_to(enemy_target.position))
				position += global_position.direction_to(enemy_target.global_position)*speed*delta
			else:
				queue_free()
		fixed:
			position += mov*speed*delta
	
func enemy_hit(charge = 1):
	print("enemy hit!")
	hp -= charge
	if hp <= 0:
		queue_free()
		

func _on_hit_box_area_entered(area):
	print("area entered")
	if area.is_in_group("hurtbox"):
		if area.get_parent().is_in_group("enemy"):
			enemy_hit(1)
		



func _on_hit_box_body_entered(body):
	print("body entered")
	if body.is_in_group("enemy"):
		print("body is enemy")
		enemy_hit(1)
