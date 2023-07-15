extends Node2D
class_name EnemyDetector

var ray_number = 16

var rays_array = []

var last_closest_enemy : Enemy
var last_closest_distance : float
# Called when the node enters the scene tree for the first time.

@onready var exception_body = get_tree().get_first_node_in_group("player")

func _ready():
	var target_vec = Vector2(0, 400)
	for i in ray_number:
		var ray = RayCast2D.new()
		ray.target_position = target_vec
		ray.add_exception(exception_body)
		ray.enabled = false
		ray.hit_from_inside = true
		target_vec = target_vec.rotated(deg_to_rad(360/ray_number))
		add_child(ray)
		rays_array.append(ray)
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_closest_enemy():
	if not is_instance_valid(last_closest_enemy):
		last_closest_enemy = null
		last_closest_distance = 160000
		
	for ray in rays_array:
		ray.force_raycast_update()

		if not ray.is_colliding():
			continue
			
		if position.distance_squared_to(to_local(ray.get_collision_point())) < last_closest_distance and ray.get_collider() is Enemy:
			last_closest_enemy = ray.get_collider()
			last_closest_distance = position.distance_squared_to(to_local(ray.get_collision_point()))
	print(last_closest_enemy)
	return last_closest_enemy

func check_for_enemies():
	for ray in rays_array:
		ray.force_raycast_update()
		if ray.is_colliding():
			return true
			
	return false
