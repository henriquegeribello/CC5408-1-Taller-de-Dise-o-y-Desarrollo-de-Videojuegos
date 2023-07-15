extends MarginContainer


@onready var player = get_tree().get_first_node_in_group("player")
@onready var player_attack_node = player.get_node("Attack")
@onready var init_attacks = player_attack_node.init_attacks
@onready var ice_button = $PanelContainer/MarginContainer/HBoxContainer/iceButton
@onready var thunder_button = $PanelContainer/MarginContainer/HBoxContainer/thunderButton
@onready var melee_button = $PanelContainer/MarginContainer/HBoxContainer/meleeButton



# Called when the node enters the scene tree for the first time.
func _ready():
	player.level_up.connect(_on_level_up)
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_level_up():
	ice_button.tooltip_text = get_upgrade_tooltip(ice_button.attack_name)
	thunder_button.tooltip_text = get_upgrade_tooltip(thunder_button.attack_name)
	melee_button.tooltip_text = get_upgrade_tooltip(melee_button.attack_name)
	show()
	get_tree().paused = true

func _on_upgrade_btn_pressed(attack : String):
	print("upgrade")
	player_attack_node.upgrade_attack(attack)
	
	hide()
	get_tree().paused = false

func _on_ice_btn_pressed():
	_on_upgrade_btn_pressed("ice_spear")

func _on_thunder_btn_pressed():
	_on_upgrade_btn_pressed("lightning_bird")
	
func _on_melee_btn_pressed():
	_on_upgrade_btn_pressed("iron_slash")

func get_upgrade_tooltip(attack):
	return player_attack_node.get_upgrade_tooltip(attack)
