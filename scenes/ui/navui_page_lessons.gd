extends NavuiPage

const dir_lessons: String = "res://data/simulations/lessons"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sections = [
		{"type": "list", "title": "Lessons", "dir": dir_lessons, "capacity": 10}
	]
	load_page()
