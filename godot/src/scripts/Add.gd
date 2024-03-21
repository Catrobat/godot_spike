extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	API.insert(42)
	API.insert(69)
	API.insert(88)
	API.insert(420)
	API.insert(666)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	print(API.get_ast())


func _on_pressedQA():
	get_tree().change_scene_to_file("res://src/scenes/statements.tscn")
