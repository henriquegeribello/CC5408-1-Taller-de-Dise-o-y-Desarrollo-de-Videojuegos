extends Button
class_name AttackUpgradeButton

@export var attack_name := "ice_spear"

@onready var upgradeMenu = get_parent().get_parent().get_parent().get_parent()

func _on_button_pressed():
	print("upgrade pressed")
	upgradeMenu._on_upgrade_btn_pressed("ice_spear")
