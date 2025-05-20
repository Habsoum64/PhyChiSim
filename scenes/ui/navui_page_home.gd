extends NavuiPage

const dir_lessons: String = "res://data/simulations/lessons"
const dir_my_simulations: String = "res://data/simulations/my_simulations"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sections = [
		{"type": "slideshow", "title": "Lessons", "dir": dir_lessons, "capacity": 10},
		{"type": "list", "title": "Simulations", "dir": dir_my_simulations, "capacity": 10}
	]
	load_page()
