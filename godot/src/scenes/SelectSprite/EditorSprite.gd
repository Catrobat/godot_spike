extends Node2D


func setup(path):
	var button = get_children()[0]
	button.text = path
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://src/scenes/EditScript/main.tscn")
