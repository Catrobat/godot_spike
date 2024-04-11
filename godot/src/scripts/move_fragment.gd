extends Button

const Constants = preload("res://src/scripts/api_interop.gd")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	API.insert(Constants.FRAGID_MOVE)


#############################################################

signal updated_ast


func _on_updated_ast():
	pass  # Replace with function body.
