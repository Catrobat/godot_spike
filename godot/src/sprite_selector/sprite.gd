extends DragAndDropItem


func setup(path):
	var img = Image.new()
	img.load(path)
	var tex = ImageTexture.new()
	tex.set_image(img)
	var label = get_node("VBoxContainer/Label")
	$VBoxContainer/TextureRect.texture = tex
	$VBoxContainer/Label.text = path
	self.expand_icon = true


func _ready():
	set_process_input(false)


#func _get_drag_data(_at_position: Vector2):
#	set_drag_preview(get_preview_controll())
#	target = get_parent().get_node(self.get_path()).get_index(true)
#	return self

#func _can_drop_data(_at_position, data):
#	target = get_parent().get_node(self.get_path()).get_index(true)
#	var node = get_parent().get_node(data.get_path())
#	get_parent().move_child(node, target)
#	return true

#func get_preview_controll():
#	return duplicate()

#func _drop_data(_at_position, data):
#	var node = get_parent().get_node(data.get_path())
#	get_parent().move_child(node, target)


func _on_pressed():
	get_tree().change_scene_to_file("res://src/script_editor/main.tscn")
