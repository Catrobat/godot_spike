extends Control


func setup(path):
	self.text = path


func _on_pressed():
	get_tree().change_scene_to_file("res://src/scenes/script_fragment.tscn")
