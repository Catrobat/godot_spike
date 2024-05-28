@tool
class_name DragNode
extends Control

@onready var target = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("draggable_node")


func _get_drag_data(_at_position: Vector2):
	set_drag_preview(get_preview_controll())
	return self


func get_preview_controll():
	return duplicate()


func _drop_data(_at_position, data):
	var node = get_node(data.get_path())
	if data.is_in_group("draggable_leaf"):
		target = get_parent().get_node(self.get_path()).get_index(true)
		node = get_parent().get_node(data.get_path())
	else:
		target = get_parent().get_node(self.get_path()).get_index(true)
		node = get_parent().get_node(data.get_path())


func _can_drop_data(_at_position, data):
	var node = get_node(data.get_path())
	if data.is_in_group("draggable_leaf"):
		target = get_parent().get_node(self.get_path()).get_index(true)
		node = get_parent().get_node(data.get_path())
	else:
		target = get_parent().get_node(self.get_path()).get_index(true)
		node = get_parent().get_node(data.get_path())
	return true
