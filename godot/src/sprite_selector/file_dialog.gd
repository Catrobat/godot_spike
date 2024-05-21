extends FileDialog


func _on_file_selected(path):
	print("HELL")
	API.sprite_add(path)
	print("GOO")
