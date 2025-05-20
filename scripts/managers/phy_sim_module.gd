extends Control

var count_ball: int = 0
var count_box: int = 0
var count_cord: int = 0

const objects: Array[String] = ["ball", "box", "cord"]
const actions: Array[String] = ["interact", "delete", "freeze"]

@onready var show_stats: bool = true
@onready var show_tools: bool = true

@onready var toolbox_obj = ToolBoxObjects.new()
@onready var toolbox_act = ToolBoxActions.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_toolboxes()
	cursor_manager.update_cursor_icon()
	global_sim_variables.obj_interact = true


# Loading the toolbox contents
func load_toolboxes():
	for obj in objects:
		var button: Button = Button.new()
		match obj:
			"ball": button.set_button_icon(preload("res://assets/icons/objects/balls/ball_yoga.svg"))
			"box": button.set_button_icon(preload("res://assets/icons/objects/boxes/box1.svg"))
			"cord": button.set_button_icon(preload("res://assets/icons/objects/cords/cord.svg"))
		button.custom_minimum_size = Vector2(50, 50)
		button.expand_icon = true
		button.name = "*" + obj
		#button.text = obj
		$UIelements/Tools/ToolboxObjects/ToolsPalette.add_child(button)
	for action in actions:
		var button: Button = Button.new()
		match action:
			"interact": button.set_button_icon(preload("res://assets/icons/ui/toolbox_actions/interact.svg"))
			"delete": button.set_button_icon(preload("res://assets/icons/ui/toolbox_actions/delete2.svg"))
			"freeze": button.set_button_icon(preload("res://assets/icons/ui/toolbox_actions/freeze.svg"))
		button.custom_minimum_size = Vector2(50, 50)
		button.expand_icon = true
		button.name = action
		#button.text = action
		$UIelements/Tools/ToolboxActions/ToolsPalette.add_child(button)
	toolbox_obj.buttons = $UIelements/Tools/ToolboxObjects/ToolsPalette.get_children()
	toolbox_act.buttons = $UIelements/Tools/ToolboxActions/ToolsPalette.get_children()
	toolbox_obj.make_connections()
	toolbox_act.make_connections()


func load_scene():
	pass


func set_throw() -> void:
	pass


func _input(event):
	if cursor_manager.cursor_mode == "spawn":
		if event is InputEventMouseButton and event.is_pressed:
			var obj: Node2D
			obj = object_spawner.spawn_object_at(object_selector.selected_object, event.position)
			match obj.get_meta("name"):
				"Ball": count_ball += 1
				"Box": count_box += 1
				"Cord": count_cord += 1
			cursor_manager.set_mode("interact")


func save_simulation(title: String) -> void:
	var file_path = "res://data/simulations/my_simulations/" + title + ".tscn"
	var scene = PackedScene.new()
	scene.pack(get_tree().current_scene)
	ResourceSaver.save(scene, file_path)


func _on_save_button_button_down() -> void:
	save_simulation("new_simulation1")


func _on_show_tools_btn_button_down() -> void:
	if show_tools:
		$UIelements/Tools.hide()
		$UIelements/ShowToolsBtn.text = "Show tools"
	else:
		$UIelements/Tools.show()
		$UIelements/ShowToolsBtn.text = "Hide tools"
	show_tools = !show_tools


func _on_show_stats_btn_button_down() -> void:
	if show_stats:
		$StatsView.show()
		$UIelements/ShowStatsBtn.text = "Hide stats"
	else:
		$StatsView.hide()
		$UIelements/ShowStatsBtn.text = "Show stats"
	show_stats = !show_stats


func _on_quit_btn_button_down() -> void:
	scene_manager.load_scene("res://scenes/ui/navui.tscn")
