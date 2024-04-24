@tool
class_name DragAndDropItem
extends Button

@onready var target = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	button_up.connect(_on_pressed)


func _on_pressed():
	assert(false, "method not implemented")


func _get_drag_data(_at_position: Vector2):
	set_drag_preview(get_preview_controll())
	target = get_parent().get_node(self.get_path()).get_index(true)
	return self


func _can_drop_data(_at_position, data):
	target = get_parent().get_node(self.get_path()).get_index(true)
	var node = get_parent().get_node(data.get_path())
	get_parent().move_child(node, target)
	return true


func get_preview_controll():
	return duplicate()


func _drop_data(_at_position, data):
	var node = get_parent().get_node(data.get_path())
	get_parent().move_child(node, target)

#func _on_pressed():
#	get_tree().change_scene_to_file("res://src/script_editor/script_fragment.tscn")
