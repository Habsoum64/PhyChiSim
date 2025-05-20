extends Control

var section_title: String
var files: Array[String]
var capacity: int
var dest_node: Node
var content_type


func _ready() -> void:
	$SectionTitle.text = section_title
	match get_meta("navui_group_type"):
		"list": 
			dest_node = $VBoxContainer
			content_type = "res://scenes/ui/navui-content_row.tscn"
		"slideshow": 
			dest_node = $ScrollContainer/HBoxContainer
			content_type = "res://scenes/ui/navui-content_card.tscn"
	
	for i in range(files.size()):
		if i == capacity:
			break
		
		var content
		var file: String
		file = files[i]
		content = load(content_type).instantiate()
		content.file_path = file
		content.file_name = file.get_file()
		content.last_modified = Time.get_datetime_string_from_unix_time(FileAccess.get_modified_time(file))
		dest_node.add_child(content)
