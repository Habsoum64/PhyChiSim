extends Node

var cursor_mode: String = "move" # default mode
var modes: Array = ["delete", "interact", "pan", "spawn", "set_throw", "real-time_throw"]

@onready var csk_delete = preload("res://assets/cursor_delete.png")
@onready var csk_move = preload("res://assets/cursor_move.png")

func set_mode(mode: String) -> void:
	if mode not in modes:
		cursor_mode = "interact"
		print("Invalid cursor mode; mode set to default")
	else:
		cursor_mode = mode
		print("Cursor mode: ", mode)
	update_cursor_icon()


func update_cursor_icon() -> void:
	match cursor_mode:
		"delete":
			Input.set_custom_mouse_cursor(csk_move)
		"interact":
			Input.set_custom_mouse_cursor(csk_move)


func get_mode() -> String:
	return cursor_mode

func update_interact_mode() -> void:
	match cursor_mode:
		"delete":
			global_sim_variables.obj_interact = true
		"interact":
			global_sim_variables.obj_interact = true
		"pan":
			global_sim_variables.obj_interact = false
