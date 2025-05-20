extends Control

class_name ToolBoxObjects

var buttons: Array


func _on_object_pressed(obj_name: String):
	object_selector.select_object(obj_name)
	cursor_manager.set_mode("spawn")

func make_connections():
	for button in buttons:
		button.connect("pressed", Callable(_on_object_pressed).bind(button.name))
	print("Buttons connected.")
