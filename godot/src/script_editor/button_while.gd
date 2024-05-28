extends Button

const MoveFragment: Resource = preload(
	"res://src/script_editor/fragments/move_fragment/while_fragment.tscn"
)


func _on_pressed():
	API.insert(200)
	(
		get_tree()
		. get_current_scene()
		. get_node("VBoxContainer/VScrollContainer/AutoRefresh/Code")
		. add_child(MoveFragment.instantiate())
	)
