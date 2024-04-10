extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_add_sprite_button_pressed():
	$FileDialog.popup_centered()


func _on_file_dialog_file_selected(path):
	var sprite = Sprite2D.new()
	var image = Image.new()
	if image.load(path) != OK:
		return

	sprite.texture = ImageTexture.create_from_image(image)

	var screen_size = get_viewport_rect().size
	var sprite_size = sprite.texture.get_size()
	var sprite_position = (screen_size - sprite_size) / 2
	sprite.position = sprite_position

	add_child(sprite)
