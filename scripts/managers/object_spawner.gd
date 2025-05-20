extends Node

class_name ObjectSpawner

# Dictionnary of available physics objects
const OBJECT_SCENES = {
	"*ball": "res://scenes/objects/objects_physics/ball.tscn",
	"*box": "res://scenes/objects/objects_physics/box.tscn",
	"*cord": "res://scenes/objects/objects_physics/cord.tscn",
	"*ground": "res://scenes/objects/objects_physics/ball.tscn",

	"*atom": "res://scenes/objects/objects_chemistry/atom.tscn",
	"*bond": "res://scenes/objects/objects_chemistry/bond.tscn",
	"*molecule": "res://scenes/objects/objects_chemistry/molecule.tscn"
}

var spawn_on: bool = false
var last_spawn_pos: Vector2
@onready var object: String = object_selector.selected_object


func spawn_object(object_id: String):
	if object_id not in OBJECT_SCENES:
		print("Error: object not found in dictionnary")
		spawn_on = false
		return null
	var object_scene: Resource = load(OBJECT_SCENES[object_id])
	if object_scene:
		var new_object: Node2D = object_scene.instantiate()
		get_tree().current_scene.add_child(new_object)
		return new_object
	else: print("Error: Failed to load object scene: ", OBJECT_SCENES[object_id])
	return null


# Spawn an object in the scene at a given position
func spawn_object_at(object_id: String, spawn_position: Vector2):
	last_spawn_pos = spawn_position
	var obj = spawn_object(object_id)
	if obj:
		if object_id == "*cord":
			obj.position = spawn_position
			print("Spawned: ", object_id, " at ", spawn_position)
		else:
			obj.position = Vector2.ZERO
			print("Spawned: ", object_id)
		return obj


'''
if object_id not in OBJECT_SCENES:
		print("Error: object not found in dictionnary")
		spawn_on = false
		return null
	var object_scene: Resource = load(OBJECT_SCENES[object_id])
	if object_scene:
		last_spawn_pos = spawn_position
		var new_object = object_scene.instantiate()
		new_object.position = Vector2.ZERO
		get_tree().current_scene.add_child(new_object)
		print("Spawned: ", object_id, " at ", spawn_position)
		return new_object
	else: print("Error: Failed to load object scene: ", OBJECT_SCENES[object_id])
	return null
'''
