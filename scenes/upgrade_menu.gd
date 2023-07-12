extends MarginContainer


@onready var player = get_tree().get_first_node_in_group("player")
@onready var player_attack_node = player.get_node("Attack")
@onready var init_attacks = player_attack_node.init_attacks
@onready var iceButton = %iceButton
@onready var thunderButton = %thunderButton
@onready var meleeButton = %meleeButton


# Called when the node enters the scene tree for the first time.
func _ready():
	iceButton.pressed.connect(_on_upgrade_btn_pressed.bind("ice_spear"))
	thunderButton.pressed.connect(_on_upgrade_btn_pressed.bind("lightning_bird"))
	meleeButton.pressed.connect(_on_upgrade_btn_pressed.bind("iron_slash"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_upgrade_btn_pressed(attack):
	player_attack_node.upgrade_attack(attack)
	
