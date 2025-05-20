extends Node

class_name SceneManager

var last_scene: String = ""

# Path to main_menu scene
const MAIN_MENU_PATH = "res://scenes/ui/main_menu.tscn"


# Basic scene loading
func load_scene_direct(scene_path: String):
	if not ResourceLoader.exists(scene_path):
		print("Error: Scene not found - " + scene_path)
		return
	last_scene = get_tree().current_scene.get_path()
	get_tree().change_scene_to_file(scene_path)

# Scene loading with transition animation/process
func load_scene(scene_path: String):
	if not ResourceLoader.exists(scene_path):
		print("Error: Scene not found - " + scene_path)
		return
	if transition_layer != null:
		transition_layer.fade_out(scene_path)
	else:
		print("Warning: Transition layer not found, switching scene instantly!")
		load_scene_direct(scene_path)  # Fallback if transition fails


# Reload current scene
func reload_scene():
	var current_scene = get_tree().current_scene
	get_tree().change_scene_to_file(current_scene)
	

# Return directly to main menu
func return_to_main_menu():
	get_tree().change_scene_to_path(MAIN_MENU_PATH)
 
