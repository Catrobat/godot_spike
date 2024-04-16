extends VBoxContainer

const Constants = preload("res://src/scripts/api_interop.gd")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_move_fragment_button_pressed():
	API.insert(200)
