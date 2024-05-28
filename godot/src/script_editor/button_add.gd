extends Button

const TurnFragment: Resource = preload(
	"res://src/script_editor/fragments/move_fragment/move_fragment.tscn"
)


func _on_pressed():
	API.insert(200)
	(
		get_tree()
		. get_current_scene()
		. get_node("VBoxContainer/VScrollContainer/AutoRefresh/Code")
		. add_child(TurnFragment.instantiate())
	)
