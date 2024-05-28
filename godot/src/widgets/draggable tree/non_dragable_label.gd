@tool
class_name NonDragLabel
extends Control
@onready var target = 0


func _ready():
	add_to_group("draggable_node_label")


func _get_drag_data(_at_position: Vector2):
	print("get drag label")
	set_drag_preview(get_preview_controll())
	print(get_preview_controll())
	print(get_parent())
	return get_parent().get_parent()


func get_preview_controll():
	return get_parent().get_parent().duplicate()


func _can_drop_data(_at_position, data):
	var node
	print("nondarg label")
	print(data)
	if data.is_in_group("draggable_leaf"):
		target = (get_node(get_parent().get_parent().get_path()).get_index(true))
		node = get_node(data.get_path())
		get_parent().get_parent().move_child(node, target)
	else:
		if get_parent().get_parent() == data:
			return false
		target = get_node(self.get_parent().get_parent().get_path()).get_index(true)
		node = get_node(data.get_path())
		print(data.get_path())
		get_parent().get_parent().get_parent().move_child(node, target)
	return true
