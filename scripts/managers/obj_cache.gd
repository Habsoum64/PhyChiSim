extends Node

var deleted_objects: Array = []

func delete_object(object: Node2D) -> void:
	deleted_objects.append({ "scene": object.scene_file_path, "position": object.global_position })
	object.queue_free()

func undo_delete() -> void:
	if deleted_objects.size() > 0:
		var last_deleted = deleted_objects.pop_back()
		var scene = load(last_deleted["scene"]).instantiate()
		scene.global
