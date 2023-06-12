extends CharacterBody2D

var movement_speed = 50.0
var movement_array = []

var hp = 10  


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var shdwtimeline := ShadowTimeline.new()

@onready var shadw = get_tree().get_first_node_in_group("Shadow")
@onready var pivot = $Pivot
@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")

func _physics_process(delta):
	movement()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
	#	velocity.x = direction * SPEED
	#else:
	#	velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if Input.is_action_just_pressed("ui_accept"):
		shadw.global_position = global_position
		shadw.movementArray = movement_array
		shadw.movementCounter = 0	
		
	
	
	
func movement():
	var x_mov = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_mov = Input.get_action_strength("down") - Input.get_action_strength("up")
	var mov = Vector2(x_mov, y_mov)
	movement_array.append(mov)
	velocity = mov.normalized()*movement_speed

	if mov:
		playback.travel("run")
		if mov.x:
			pivot.scale.x = sign(mov.x)	
	else:
		playback.travel("idle")
	move_and_slide() 


func _on_hurt_box_hurt(damage):
	hp -= damage 
	print(hp)
