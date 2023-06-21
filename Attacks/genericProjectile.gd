extends Node2D
class_name genericProjectile
# Mechanic handling parameters
enum {simple, homing, fixed, melee}
var type = simple
var level = 1
var hp = 1
var speed = 100
var damage = 5
var kback_amount = 100
var attack_size = 1.0
var flight_time = 10

var collision = "res://Attacks/Collisions/capsule_collision.tres"
var collision_rot = deg_to_rad(-90)

# Variables used by the different projectile types

# Simple
var target_pos = Vector2(1, 0)
var angle = Vector2.ZERO

# Fixed
var mov = Vector2.ZERO 

# Homing
var enemy_target : Enemy

# Melee
var shift = Vector2(1, 0)


# Sprite params
var sprite = load("res://assets/attacks/IceVFX 1 Repeatable.png")
var hframes = 8
var vframes = 1
var sprite_rotation = 0
var frame = 0.0
var frame_speed = 1.0

@onready var player = get_tree().get_first_node_in_group("player")
@onready var flightTimer = $flightTimer


func _ready():
	$Sprite2D.texture = sprite
	$Sprite2D.hframes = hframes
	$Sprite2D.vframes = vframes
	$Sprite2D.rotation = sprite_rotation
	
	$HitBox/CollisionShape2D.set_shape(load(collision))
	$HitBox/CollisionShape2D.rotate(collision_rot)
	
	rotate(get_angle_to(target_pos + position))
	flightTimer.wait_time = flight_time
	flightTimer.start()
	
	match type:
		melee:
			frame_speed = hframes/flight_time
		_:
			frame_speed = 0.2*30

func _process(delta):
	$Sprite2D.set_frame(floor(frame))

	frame += frame_speed*delta
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
		melee:
			position = player.global_position + target_pos.normalized()*50
	
func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		queue_free()
		

func _on_hit_box_area_entered(area):
	if area.is_in_group("hurtbox"):
		var parent = area.get_parent()
		if parent.is_in_group("enemy"):
			enemy_hit(1)
		elif parent.is_in_group("player"):
			pass # TODO: add exp



func _on_hit_box_body_entered(body):
	print("body entered")
	if body.is_in_group("enemy"):
		print("body is enemy")
		enemy_hit(1)


func _on_flight_timer_timeout():
	queue_free()
