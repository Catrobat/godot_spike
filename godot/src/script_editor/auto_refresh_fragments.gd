extends AutoRefresh

const MoveFragmentLabel: Resource = preload("res://src/script_editor/code_fragment_move.tscn")


func _refresh_contents():
	var ast = Api.get_ast()
	render_ast(ast)


func render_ast(ast):
	var code_container := $Code
	for old in code_container.get_children():
		code_container.remove_child(old)

	for fragment in ast:
		code_container.add_child(MoveFragmentLabel.instantiate())
