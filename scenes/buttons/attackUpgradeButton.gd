extends Button
class_name AttackUpgradeButton

@export var attack_name := "ice_spear"

@onready var upgradeMenu = get_parent().get_parent().get_parent().get_parent()


func _on_button_pressed():
	upgradeMenu._on_upgrade_btn_pressed(attack_name)

func _make_custom_tooltip(for_text):
	var label = Label.new()
	var settings = LabelSettings.new()
	label.text = for_text
	label.label_settings = settings
	return label
