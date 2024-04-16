extends Control

var Sprites: Resource = preload("res://src/SpriteSelector/sprite.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	_on_file_dialog_file_selected("Default Sprite")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_add_sprite_button_pressed():
	$FileDialog.popup_centered()


func _on_file_dialog_file_selected(path):
	var sprite: Button = Sprites.instantiate()
	sprite.setup(path)
	get_node("VBox").add_child(sprite)
