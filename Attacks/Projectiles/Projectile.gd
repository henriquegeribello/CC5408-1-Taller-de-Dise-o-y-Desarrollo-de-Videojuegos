extends Resource
class_name Projectile

# Spawner params
@export var max_level: int
@export var base_ammo: int
@export var reload_speed: float
@export var fire_rate: float
@export var nextlvl : Projectile

# Bullet mechanic handling params
@export var level: int
@export_enum("fire", "ice", "lightning", "phys") var element: int
@export_enum("simple", "homing", "fixed", "melee") var type: int
@export var mov : Vector2
@export var hp:= 1
@export var speed:=100
@export var knockback:= 100
@export var attack_size:= 1.0
@export var damage:= 5
@export var flight_time := 10
@export var collision = "res://Attacks/Collisions/capsule_collision.tres"
@export var collision_rot = deg_to_rad(-90)
@export var shift := Vector2(0, 1)

#@export var 

# Sprite handling params
@export var sprite : Texture2D
@export var hframes := 10
@export var vframes := 1
@export var rotation := 0

#flavor params
@export var name: String
@export_multiline var description: String



func level_up():
	level += 1
	hp += 1
	damage += 5
