extends Sprite2D

var movementArray = []
var movementCounter = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(50):
		var x = randfn(0, 1)
		var y = randfn(0, 1)
		movementArray.append(Vector2(x, y))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mov = movementArray[movementCounter]
	velocity = mov.normalized()*movement_speed
	move_and_slide() 
