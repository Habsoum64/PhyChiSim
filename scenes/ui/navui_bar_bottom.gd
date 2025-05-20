extends Control

#@onready var nav_buttons: Array[Node] = [$ColorRect/BottomContainer/Home, $ColorRect/BottomContainer/Lessons, $ColorRect/BottomContainer/Library, $ColorRect/BottomContainer/History]


func _on_new_button_down() -> void:
	scene_manager.load_scene("res://scenes/simulation/physics/PhySim.tscn")


'''
func _on_button_pressed():
	get_node("/root/Navui").content_loaded = false

func make_connections():
	for button in nav_buttons:
		button.connect("pressed", Callable(_on_button_pressed))
	print("Navui-bar_bottom buttons connected.")
'''

func set_page(path: String) -> void:
	var uinode = get_node("/root/Navui/HBoxContainer/ScrollView")
	if uinode.get_child(0):
		uinode.get_child(0).queue_free()
	var page = load(path).instantiate()
	uinode.add_child(page)

func _on_home_pressed() -> void:
	set_page("res://scenes/ui/navui-page_home.tscn")


func _on_lessons_pressed() -> void:
	set_page("res://scenes/ui/navui-page_lessons.tscn")


func _on_library_pressed() -> void:
	set_page("res://scenes/ui/navui-page_library.tscn")


func _on_history_pressed() -> void:
	set_page("res://scenes/ui/navui-page_history.tscn")
