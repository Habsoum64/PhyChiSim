extends NavuiPage

const dir_lessons: String = "res://data/simulations/lessons"
const dir_my_simulations: String = "res://data/simulations/my_simulations"


func _ready():
	sections = [
		{"type": "list", "title": "Some Simulations", "dir": dir_my_simulations, "capacity": 10}
	]
	load_page()
