extends CharacterBody2D

var movement_speed = 50.0
var movement_array = []

var max_hp = 15
var hp = 15
var time = 0

var start_time_ms : int

var lvlup_exp = 15
var curr_exp = 0
var level = 0

var init_attacks = ["ice_spear", "lightning_bird", "iron_slash"]


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var shdwtimeline := ShadowTimeline.new()

@onready var shadw = get_tree().get_first_node_in_group("Shadow")
@onready var healthBar = get_node("%HealthBar")
@onready var gom = get_node("GameOverMenu")
@onready var wm = get_node("WinMenu")

signal show_menu()
signal level_up

func _ready():
	_on_hurt_box_hurt(0)
	$Attack.init_attacks = init_attacks
	#connect("show_menu",Callable(gom, "show_menu"))
	deadEnemiesCounter.text = "0"
@onready var pivot = $Pivot
@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var lbl_timer = $GUI/lblTimer
@onready var deadEnemiesCounter = $GUI/deadEnemiesCounter
@onready var numberOfDeadEnemies = get_parent().get_node("EnemySpawner").number_of_enemies_slayed_by_the_player


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
	
	#if Input.is_action_just_pressed("ui_accept"):
	#	shadw.global_position = global_position
	#	shadw.movementArray = movement_array
	#	shadw.movementCounter = 0
	#	save_run()	


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
	playback.travel("take damage")
	hp -= damage 
	healthBar.max_value = max_hp
	healthBar.value = hp
	
	if hp <= 0:
		#emit_signal("show_menu")
		save_run()
		gom.show_menu()

		

func change_time(argtime = 0):
	time = argtime
	if argtime > 169:
		wm.show_menu()
	var minutes = int(time/60)
	var seconds = time % 60
	if minutes < 10 :
		minutes = str(0,minutes)
	if seconds < 10:
		seconds = str(0,seconds)
	lbl_timer.text = str(minutes,":",seconds)

	
func save_run():
	shdwtimeline.movement_array = movement_array
	shdwtimeline.init_attacks = ["res://Attacks/Projectiles/iceSpear.tres", "res://Attacks/Projectiles/ironSlash.tres", "res://Attacks/Projectiles/lightningBird.tres"]
	shdwtimeline.time_of_death = Time.get_ticks_msec() - start_time_ms
	ResourceSaver.save(shdwtimeline, "user://last_game_timeline.tres")

func change_deadEnemiesCounter(numberOfDeadEnemies):
	deadEnemiesCounter.text = str(numberOfDeadEnemies)

func add_xp(xp = 1):
	curr_exp += xp
	if curr_exp >= lvlup_exp and level<15:
		curr_exp = 0
		lvlup_exp = int(lvlup_exp*1.3)
		emit_signal("level_up")
		level +=1
		

func upgrade_attack(attack):
	if $Attack.upgrade_attack(attack) == 1:
		shdwtimeline.timestamps.append(Time.get_ticks_msec() - start_time_ms)
		shdwtimeline.attack_array.append(attack)
	else:
		return -1

