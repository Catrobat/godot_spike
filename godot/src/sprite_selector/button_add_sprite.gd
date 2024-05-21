extends Button


func _on_pressed():
	$FileDialog.popup_centered()


func _on_file_dialog_file_selected(path):
	print_debug("HFefe")
	API.sprite_add(path)
	print_debug("djuashduis")
