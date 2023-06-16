extends Sprite2D

var movementArray = []
var movementCounter = 0

var timeline : ShadowTimeline
var mov : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(50):
		movementArray.append(Vector2(0, 0))
		
	if FileAccess.file_exists("res://Shadow/Timelines/last_game_timeline.tres"):
		timeline = load("res://Shadow/Timelines/last_game_timeline.tres")
		movementArray = timeline.movement_array
		
		$Attack.init_attacks = timeline.init_attacks
		$Attack.attack_event_timeline = timeline.events
		$Attack.attack_timestamps = timeline.timestamps
		
		$deathTimer.wait_time = timeline.time_of_death
		$deathTimer.start()
		
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mov = movementArray[movementCounter]
	position += mov
	movementCounter+=1
	movementCounter = movementCounter%movementArray.size()




func _on_death_timer_timeout():
	queue_free()
