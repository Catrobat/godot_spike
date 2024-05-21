extends AutoRefresh

const Sprite: Resource = preload("res://src/sprite_selector/sprite.tscn")


func _refresh_contents():
	var sprites = Api.sprite_get_all()
	render_sprites(sprites)


func render_sprites(sprites):
	var code_container := $VBoxIntems
	for old in code_container.get_children():
		code_container.remove_child(old)

	for path in sprites:
		var sprite = Sprite.instantiate()
		sprite.setup(path)
		code_container.add_child(sprite)
