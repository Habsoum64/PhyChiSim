extends Node

class_name ToolsPalette

var buttons: Array
#var obj_spawn: ObjectSpawner = ObjectSpawner.new()


func _on_object_pressed(obj_name: String):
	print(obj_name)
	if obj_name.contains("*"):
		object_selector.select_object(obj_name)

func _on_move_pressed():
	object_selector.off_select()

func _on_delete_pressed():
	object_selector.off_select()
	

func make_connections():
	for button in buttons:
		var bname: String = button.name
		if bname.contains("*"):
			button.connect("pressed", Callable(_on_object_pressed).bind(bname))
		else:
			if bname == "move":
				button.connect("pressed", "_on_move_pressed")
			elif bname == "delete":
				button.connect("pressed", Callable(_on_object_pressed).bind(bname))
	print("Buttons connected.")
