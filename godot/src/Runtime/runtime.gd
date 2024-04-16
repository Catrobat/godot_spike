extends Node2D


func _ready():
	var compile_output: String = Api.compile()
	_evaluate(compile_output)


func _process(_delta):
	pass


func _evaluate(script: String) -> void:
	print(script)
	var sprite: Sprite2D = Sprite2D.new()
	var gd_script: GDScript = GDScript.new()
	gd_script.set_source_code(script)
	gd_script.reload()
	sprite.set_script(gd_script)
	sprite.texture = load("res://assets/ui/icon.svg")
	add_child(sprite)
	print(sprite.position)
