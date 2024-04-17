extends Control

var new_project_name: String = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	var new_project: Button = Button.new()
	new_project.text = "Default project"
	$MarginContainer/VBoxContainer/YourProjectsMenuButton.get_popup().add_item(new_project.text)
	$MarginContainer/VBoxContainer/YourProjectsMenuButton.get_popup().id_pressed.connect(
		_on_new_project_button_pressed
	)
	$CreateProjectWindow.hide()
	call_deferred("open_menu")


func open_menu() -> void:
	$MarginContainer/VBoxContainer/YourProjectsMenuButton.show_popup()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_create_project_button_pressed():
	$CreateProjectWindow.popup_centered()


func _on_create_project_window_close_requested():
	$CreateProjectWindow.hide()


func _on_submit_button_pressed():
	var new_project: Button = Button.new()
	new_project.text = self.new_project_name
	if self.new_project_name.is_empty():
		$CreateProjectWindow/GridContainer/RequiredNameLabel.visible = true
		return
	$MarginContainer/VBoxContainer/YourProjectsMenuButton.get_popup().add_item(
		self.new_project_name
	)
	$CreateProjectWindow.hide()


func _on_project_name_line_edit_text_changed(new_text):
	$CreateProjectWindow/GridContainer/RequiredNameLabel.visible = false
	new_project_name = new_text


func _on_new_project_button_pressed(_id: int):
	get_tree().change_scene_to_file("res://src/sprite_selector/add_sprite.tscn")


func _on_your_projects_menu_button_pressed():
	pass
