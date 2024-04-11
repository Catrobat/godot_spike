extends Control

var Sprites: Resource = preload("res://src/scenes/sprite.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_add_sprite_button_pressed():
	$FileDialog.popup()


func _on_file_dialog_file_selected(path):
	var sprite: Button = Sprites.instantiate()
	sprite.setup(path)
	sprite.custom_minimum_size.x = 80
	sprite.custom_minimum_size.y = 30
	sprite.size_flags_horizontal = Control.SIZE_FILL
	sprite.size_flags_vertical = Control.SIZE_SHRINK_END | Control.SIZE_EXPAND
	sprite.size_flags_stretch_ratio = 0
	get_node("VBox").add_child(sprite)
	print_tree_pretty()
