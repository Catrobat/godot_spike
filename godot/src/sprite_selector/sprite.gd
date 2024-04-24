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


func _on_pressed():
	get_tree().change_scene_to_file("res://src/script_editor/main.tscn")
