extends genericProjectile
class_name meleeProjectile


func _ready():
	$Sprite2D.texture = sprite
	$Sprite2D.hframes = hframes
	$Sprite2D.vframes = vframes
	$Sprite2D.rotation = sprite_rotation
	$Sprite2D.scale = Vector2(attack_size, attack_size)
	
	$HitBox/CollisionShape2D.set_shape(load(collision))
	$HitBox.position += collision_shift
	$HitBox/CollisionShape2D.shape.set_radius($HitBox/CollisionShape2D.shape.get_radius()*sqrt(attack_size))
	$HitBox/CollisionShape2D.shape.set_height($HitBox/CollisionShape2D.shape.get_height()*sqrt(attack_size))
	$HitBox/CollisionShape2D.rotate(collision_rot)

	
	rotate(get_angle_to(target_pos + position))
	flightTimer.wait_time = flight_time
	flightTimer.start()
	
	frame_speed = hframes/flight_time

func _physics_process(delta):
	if is_instance_valid(attacker):
		position = attacker.global_position + target_pos.normalized()*40
	else:
		queue_free()

func enemy_hit(charge = 1):
	hp -= charge
