extends Node

signal script_updated


func _on_script_updated():
	print("Script update")


func _ready():
	print("Global singleton ready")
