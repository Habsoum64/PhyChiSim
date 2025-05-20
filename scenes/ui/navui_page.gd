extends Node

class_name NavuiPage

var sections: Array[Dictionary]

func load_file_list(dir: String) -> Array[String]:
	var dir_access: DirAccess = DirAccess.open(dir)
	var files: Array[String]
	files.assign(dir_access.get_files())
	for i in range(files.size()):
		files[i] = dir + "/" + files[i]
	return files


func load_content_group(type:String, title: String, dir: String, n_rows: int) -> void:
	var content_group
	match type:
		"list": content_group = load("res://scenes/ui/navui-group_list.tscn").instantiate()
		"slideshow": content_group = load("res://scenes/ui/navui-group_slideshow.tscn").instantiate()
	content_group.files = load_file_list(dir)
	content_group.section_title = title
	content_group.capacity = n_rows
	$VBoxContainer.add_child(content_group)


func load_page() -> void:
	for section in sections:
		load_content_group(
			section["type"],
			section["title"],
			section["dir"],
			section["capacity"])


func reload_page() -> void:
	get_node("/root/Navui").clear_page()
	load_page()
