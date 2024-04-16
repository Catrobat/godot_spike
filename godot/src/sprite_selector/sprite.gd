extends Control


func setup(path):
	self.text = path


func _on_pressed():
	get_tree().change_scene_to_file("res://src/script_editor/script_fragment.tscn")
