extends Sprite2D

var movementArray = []
var movementCounter = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(50):
		movementArray.append(Vector2(0, 0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mov = movementArray[movementCounter]
	position += mov
	movementCounter+=1
	movementCounter = movementCounter%movementArray.size()

