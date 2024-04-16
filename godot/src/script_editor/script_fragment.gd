extends Node

const MoveFragmentLabel: Resource = preload("res://src/script_editor/move_fragment_label.tscn")


func _ready():
	GlobalSignals.connect("script_updated", _on_script_updated)

	var ast = Api.get_ast()
	render_ast(ast)


func _process(_delta):
	pass


func _on_script_updated():
	var ast = Api.get_ast()
	render_ast(ast)


func render_ast(ast):
	print_tree_pretty()

	var code_container := $VBoxContainer/VScrollContainer/Code
	for old in code_container.get_children():
		code_container.remove_child(old)

	for fragment in ast:
		code_container.add_child(MoveFragmentLabel.instantiate())


func _on_run_button_pressed():
	get_tree().change_scene_to_file("res://src/runtime/runtime.tscn")
