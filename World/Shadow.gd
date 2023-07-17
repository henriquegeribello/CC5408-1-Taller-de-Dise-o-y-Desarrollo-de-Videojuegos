extends Node2D

var movementArray = []
var movementCounter = 0

var timeline : ShadowTimeline
var mov : Vector2
@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var pivot = $pivot

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
		
		$deathTimer.wait_time = timeline.time_of_death/1000
		$deathTimer.start()
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mov = movementArray[movementCounter]
	position += mov
	movementCounter+=1
	movementCounter = movementCounter%movementArray.size()
	if mov:
		playback.travel("run")
		if mov.x:
			pivot.scale.x = abs(pivot.scale.x)*sign(mov.x)
	else:
		playback.travel("idle")
		


func _on_death_timer_timeout():
	queue_free()
