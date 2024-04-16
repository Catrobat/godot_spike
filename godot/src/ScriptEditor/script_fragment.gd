extends Node

const MoveFragment: Resource = preload("res://src/ScriptEditor/MoveFragment.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignals.connect("SCRIPT_UPDATED", _on_script_updated)

	var ast = API.get_ast()
	render_ast(ast)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_script_updated():
	var ast = API.get_ast()
	render_ast(ast)


func render_ast(ast):
	#get_node("/VBox").remove()
	print_tree_pretty()

	var code_container := $VBoxContainer/VScrollContainer/Code
	for old in code_container.get_children():
		code_container.remove_child(old)

	for fragment in ast:
		code_container.add_child(MoveFragment.instantiate())
