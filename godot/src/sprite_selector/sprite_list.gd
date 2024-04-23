extends VBoxContainer

const Sprite: Resource = preload("res://src/sprite_selector/sprite.tscn")


func render_ast(ast):
	var code_container := get_tree()
	for old in code_container.get_children():
		code_container.remove_child(old)

	for fragment in ast:
		code_container.add_child(Sprite.instantiate())
