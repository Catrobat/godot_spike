extends Control

var Sprites: Resource = preload("res://src/sprite_selector/sprite.tscn")


func _on_add_sprite_button_pressed():
	$FileDialog.popup_centered()


func _on_file_dialog_file_selected(path):
	var sprite = Sprites.instantiate()
	sprite.setup(path)
	get_node("VBoxContainer2/VBox/ScrollContainer/VBoxIntems").add_child(sprite)
