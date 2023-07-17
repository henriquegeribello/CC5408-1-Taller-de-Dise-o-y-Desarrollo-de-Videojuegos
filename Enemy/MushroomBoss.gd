extends Enemy
class_name MushroomBoss

var max_hp = hp

@onready var mushSelf = load("res://Enemy/MushroomBoss.tscn")

func _on_hurt_box_hurt(damage):
	hp -= damage
	playback.travel("take hit")
	if hp <= 0:
		player.add_xp()
		playback.travel("death")
		
	elif hp == max_hp/2:
		movement_speed = 2*movement_speed
		var nn = mushSelf.instantiate()
		mushSelf.position = Vector2(randf(), randf()).normalized()*5
		nn.hp = hp
		nn.movement_speed = movement_speed
		add_sibling(nn)
	elif max_hp/10-1 <= hp and hp <= max_hp/10+1:
		movement_speed = 2*movement_speed
		var nnn = mushSelf.instantiate()
		nnn.hp = 1
		nnn.movement_speed = movement_speed
		add_sibling(nnn)
