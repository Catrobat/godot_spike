@tool
class_name DragNodeStart
extends Control

@onready var target = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("draggable_node_start")


func _get_drag_data(_at_position: Vector2):
	print("get drag start")
	set_drag_preview(get_preview_controll())
#	print(get_preview_controll())
	target = get_parent().get_node(self.get_path()).get_index(true)
	var return_node = get_parent().get_parent().get_parent()
#	print(return_node)
	return return_node


func get_preview_controll():
	return get_parent().get_parent().duplicate()


func _drop_data(_at_position, data):
	var node = get_node(data.get_path())
	print(data)
	print("drop data of start")
	if data.is_in_group("draggable_leaf"):
		target = get_parent().get_node(self.get_path()).get_index(true)
		node = get_parent().get_node(data.get_path())
	else:
		#get_parent().move_child(node, target)
		target = get_parent().get_node(self.get_path()).get_index(true)
		node = get_parent().get_node(data.get_path())


func _can_drop_data(_at_position, data):
	var node = get_node(data.get_path())
	print("can drop of start")
	if data.is_in_group("draggable_leaf"):
		target = get_parent().get_node(self.get_path()).get_index(true) + 1
		node = get_node(data.get_path())
	else:
		#get_parent().move_child(node, target)
		target = get_parent().get_node(self.get_path()).get_index(true) + 1
		node = get_node(data.get_path())
	#print(target)
	#print(node)
	#print(data.get_path())
	#print("1")
	#print(get_parent())
	#print("2")
	#get_parent().print_tree_pretty()
	#get_parent().move_child(node, target)
	node.get_parent().remove_child(node)
	get_parent().add_child(node)
	return true
