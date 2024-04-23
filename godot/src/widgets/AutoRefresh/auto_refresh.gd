class_name AutoRefresh
extends VBoxContainer


func _ready():
	# get a signal when underlying data changed
	GlobalSignals.script_updated.connect(_refresh_contents)

	# initial rendering
	_refresh_contents()


func _refresh_contents():
	# update children of this node here!
	assert(false, "_refresh_contents not implemented")
