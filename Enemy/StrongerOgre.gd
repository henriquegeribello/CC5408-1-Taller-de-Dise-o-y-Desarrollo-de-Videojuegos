extends Enemy
class_name StrongerOgre

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "death":
		queue_free() 


func _on_animation_player_animation_finished(anim_name):
	pass # Replace with function body.
