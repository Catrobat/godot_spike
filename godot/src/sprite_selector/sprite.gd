extends Control

@onready var timer = $ButtonTimer
@onready var target = 0


func setup(path):
#	var img = load(path)
	var img = Image.new()
	img.load(path)
	var tex = ImageTexture.new()
	tex.set_image(img)
	var label = get_node("VBoxContainer/Label")
	$VBoxContainer/TextureRect.texture = tex
	label.text = path

	# Optionally, adjust the TextureRect size to fit the texture

	#textureRect.texture = img
	print("tex")
	print(img)
	print(tex)
	print($VBoxContainer/TextureRect.texture)
	print("tex")
#	self.text = path
	#self.icon = tex  #ResourceLoader.load(path)
	#self.add_theme_constant_override("hseparation", 8)
	self.expand_icon = true

	print(img)
	print(path)


#	var tex = ImageTexture.new()

#	tex.create_from_image(img)
#print(tex)
#print(get_child(1).get_child(0))
#$VBoxContainer/SpriteImg.texture = img
#	get_child(1).get_child(1).set_text(path)
#print(get_child(1).get_child(0))
#print_tree_pretty()

#func _on_pressed():
#	print("press")
#	get_tree().change_scene_to_file("res://src/ScriptEditor/script_fragment.tscn")


func _ready():
	set_process_input(false)
	add_to_group("DRAGABLE")


#func _input(event):
#	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
#		print("Left mouse button is being held down.")


func _on_button_down():
	timer.start()


func _on_button_up():
	if timer.get_time_left() > 0:
		get_tree().change_scene_to_file("res://src/script_editor/script_fragment.tscn")
	timer.stop()


func _on_button_timer_timeout():
	timer.stop()


func _get_drag_data(_at_position: Vector2):
	print("cdgvsdfgsdgfdghsdf")
	set_drag_preview(get_preview_controll())
	print(get_parent())
	#print(get_parent().get_node(self.get_path()).get_index(true))
	target = get_parent().get_node(self.get_path()).get_index(true)
	printt(get_parent().get_node(self.get_path()).get_index(true))
	return self


func _can_drop_data(_at_position, data):
	#print(data)
	#print(data is Node)
	target = get_parent().get_node(self.get_path()).get_index(true)
	print(data)
	print(data is Node)
	print(data.is_in_group("DRAGABLE"))
	var node = get_parent().get_node(data.get_path())
	get_parent().move_child(node, target)
	return true  #data is Node and data.is_in_group("DRAGABLE")


func get_preview_controll():
	#var preview = ColorRect.new()
	#var size_block = $SpriteButton.rect_min_size  #get_tree().root.get_size()
	#preview.size = size_block
	#preview.color = Color(1, 0, 0, 1)
	return duplicate()


func _drop_data(_at_position, data):
	var node = get_parent().get_node(data.get_path())
	get_parent().move_child(node, target)
