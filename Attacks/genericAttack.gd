extends Resource
class_name Projectile

@export var sprite: Texture
@export var name: String
@export_multiline var description: String
@export var max_level: int
@export var level: int
@export_enum("fire", "ice", "lightning") var element: int
@export var hp:= 1
@export var speed:=100
@export var knockback:= 100
@export var attack_size:= 1.0

func level_up():
	pass
	
