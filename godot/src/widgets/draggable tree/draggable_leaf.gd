@tool
class_name DragLeaf
extends Control

@onready var target = 0


func _ready():
	add_to_group("draggable_leaf")


func _get_drag_data(_at_position: Vector2):
	set_drag_preview(get_preview_controll())
	return self


func get_preview_controll():
	return duplicate()


func _drop_data(_at_position, _data):
	pass


func _can_drop_data(_at_position, data):
	var node
	if data.is_in_group("draggable_leaf"):
		target = get_node(self.get_path()).get_index(true)
		node = get_node(data.get_path())
		get_parent().move_child(node, target)

	elif data.is_in_group("draggable_node"):
		target = get_node(self.get_path()).get_index(true)
		node = get_node(data.get_path())
		get_parent().move_child(node, target)
	else:
		print(data)
		assert(false, "Invalid node")
	return true
