extends genericProjectile
class_name simpleProjectile


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
	
	frame_speed = 0.2*30

func _physics_process(delta):
	position += target_pos*speed*delta
