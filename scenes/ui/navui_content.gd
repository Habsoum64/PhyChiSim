extends Control

var file_path: String
var file_name: String
var last_modified: String


func _ready():
	match get_meta("navui_content_type"):
		"card": 
			$FileLink/Panel/FileName.text = file_name
			$FileLink/Panel/DateModified.text = last_modified
		"row": 
			$FileLink.text = file_name
			$DateModified.text = last_modified


func _on_delete_btn_button_down() -> void:
	var dir: DirAccess = DirAccess.open(file_path.get_base_dir())
	dir.remove(file_path)
	get_node("/root/Navui/HBoxContainer/ScrollView").get_child(0).reload_page()


func _on_file_link_button_down() -> void:
	scene_manager.load_scene(file_path)


func _on_rename_btn_button_down() -> void:
	pass # Replace with function body.
