extends genericProjectile
class_name meleeProjectile


func _ready():
	$Sprite2D.texture = sprite
	$Sprite2D.hframes = hframes
	$Sprite2D.vframes = vframes
	$Sprite2D.rotation = sprite_rotation
	
	$HitBox/CollisionShape2D.set_shape(load(collision))
	$HitBox.position += collision_shift
	$HitBox/CollisionShape2D.rotate(collision_rot)

	
	rotate(get_angle_to(target_pos + position))
	flightTimer.wait_time = flight_time
	flightTimer.start()
	
	frame_speed = hframes/flight_time

func _physics_process(delta):
	position = player.global_position + target_pos.normalized()*40

func enemy_hit(charge = 1):
	hp -= charge
