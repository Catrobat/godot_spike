extends Node

var MoveFragment: Resource = preload("res://src/ScriptEditor/move_fragment.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().add_child(MoveFragment.instantiate())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
