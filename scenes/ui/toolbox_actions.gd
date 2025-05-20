extends Control

class_name ToolBoxActions

var buttons: Array
var length = $".".size


func _on_action_pressed(action: String):
	object_selector.off_select()
	cursor_manager.set_mode(action)


func make_connections():
	for button in buttons:
		button.connect("pressed", Callable(_on_action_pressed).bind(button.name))
	print("Buttons connected.")


#func resize_container() -> void:
