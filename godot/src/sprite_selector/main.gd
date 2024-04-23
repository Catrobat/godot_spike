extends Control

var Sprites: Resource = preload("res://src/sprite_selector/sprite.tscn")


func _on_add_sprite_button_pressed():
	$FileDialog.popup_centered()


func _on_file_dialog_file_selected(path):
	var sprite: Button = Sprites.instantiate()
	sprite.setup(path)
	var margin_container = MarginContainer.new()
	var margin_value = 10
	margin_container.add_theme_constant_override("margin_top", margin_value / 2)
	margin_container.add_theme_constant_override("margin_left", margin_value)
	margin_container.add_theme_constant_override("margin_bottom", margin_value / 2)
	margin_container.add_theme_constant_override("margin_right", margin_value)
	get_node("VBoxContainer2/VBox/ScrollContainer/VBoxIntems").add_child(sprite)
