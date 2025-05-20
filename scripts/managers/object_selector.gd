extends Node

class_name ObjectSelector

var selected_object = "box" # Default selected object

# Setting the object to place
func select_object(object_name: String):
	selected_object = object_name
	print("Selected_object: ", selected_object)

# Stop the object selection
func off_select():
	selected_object = ""
	print("No object selected")

# Get the current selected object
func get_selected_object():
	return selected_object
