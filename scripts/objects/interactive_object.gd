extends Node2D

class_name InteractiveObject

var dragging: bool = false
var throw_on: bool = false

var show_vec_velocity: bool
var show_vec_gravity: bool
var show_vec_reaction: bool
var show_vec_tension: bool

var show_val_velocity: bool
var show_val_gravity: bool
var show_val_reaction: bool
var show_val_tension: bool

var make_static: bool = false
var show_ctx_menu: bool = false

var offset: Vector2
var p1: Vector2
var p2: Vector2
var dir: Vector2
var vector_throw_start: Vector2
var vector_throw_end: Vector2
var vector_throw_final: Vector2

var pos_track: Array[Vector2] = [Vector2(0.0, 0.0)]
var val_names: Array[String] = ["Gravity", "Velocity"]

@onready var num: int = 0
@onready var vector_velocity = $Vectors/Velocity
@onready var vector_gravity = $Vectors/Gravity
@onready var vector_Tension = $Vectors/Tension


func _ready() -> void:
	if get_meta("name") != "Cord":
		$RigidBody2D.position = object_spawner.last_spawn_pos
	match get_meta("name"):
		"Ball": num = get_parent().count_ball
		"Box": num = get_parent().count_box
		"Cord": num = get_parent().count_cord
	name = get_meta("name") + str(num)
	set_owner(get_tree().current_scene)
	add_to_group("Bodies")
	create_value_rows(val_names)


func _physics_process(delta: float) -> void:
	#p1 = pos_track[0]
	#p2 = $RigidBody2D.position
	#pos_track[0] = p2
	#dir = p1 - p2
	update_switches()
	
	$Vectors.position = $RigidBody2D.position
	if global_sim_variables.obj_interact:
		if dragging:
			$RigidBody2D.freeze = true
			$Vectors.hide()
			$RigidBody2D.position = get_global_mouse_position() - offset
			#position = lerp(global_position, get_global_mouse_position(), 25 * delta)
		else: 
			if !make_static:
				$RigidBody2D.freeze = false
				$Vectors.show()
		
		# Gravity vector display:
		if show_vec_gravity:
			var adjusted_gravity: Vector2 = (ProjectSettings.get_setting("physics/2d/default_gravity")
				* ProjectSettings.get_setting("physics/2d/default_gravity_vector") / 10)
			draw_vector(vector_gravity, adjusted_gravity)
			
		# Velocity vector display:
		if show_vec_velocity:
			var adjusted_velocity: Vector2 = $RigidBody2D.linear_velocity/3
			#var adjusted_velocity: Vector2 = lerp((p2 - p1) ,$RigidBody2D.linear_velocity, 25 * delta)
			draw_vector(vector_velocity, adjusted_velocity)
		
		var val_row: HBoxContainer
		
		# Gravity value display
		val_row = get_node("/root/PhySim/StatsView/ValuesDisplay/" + name + "_Gravity")
		if show_val_gravity:
			if !val_row.visible:
				val_row.visible = true
			update_value(val_row, ProjectSettings.get_setting("physics/2d/default_gravity"))
		else:
			if val_row.visible:
				val_row.visible = false
		
		# Velocity value display
		val_row = get_node("/root/PhySim/StatsView/ValuesDisplay/" + name + "_Velocity")
		if show_val_velocity:
			if !val_row.visible:
				val_row.visible = true
			update_value(val_row, $RigidBody2D.linear_velocity.length())
		else:
			if val_row.visible:
				val_row.visible = false
		'''
		if show_ctx_menu:
			$"Menu-phyObj".show()
		else:
			$"Menu-phyObj".hide()'''


func _on_area_2d_mouse_entered() -> void:
	$RigidBody2D/Sprite2D.modulate.a = 0.8
	object_selector.selected_object = name


func _on_area_2d_mouse_exited() -> void:
	$RigidBody2D/Sprite2D.modulate.a = 1


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if global_sim_variables.obj_interact:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_action_pressed("ui_touch"):
				match cursor_manager.cursor_mode:
					"interact":
						dragging = true
					"delete":
						print("object deleted")
						for lab in get_node("/root/PhySim/StatsView/ValuesDisplay").get_children():
							if lab.name.contains(name):
								lab.queue_free()
						queue_free()
			else:
				dragging = false
		elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
			if event.is_action_pressed("ui_touch_right"):
				get_node("/root/PhySim/StatsView").hide()
				$"Menu-phyObj".show()
				#show_ctx_menu = true


func draw_vector(line_node, vector: Vector2) -> void:
	line_node.clear_points()
	line_node.add_point(Vector2(0, 0))
	line_node.add_point(vector)


func update_value(row: HBoxContainer, magnitude: float) -> void:
	row.get_child(1).text = str(magnitude)


func create_value_rows(value_names: Array[String]) -> void:
	for vname in value_names:
		var row: HBoxContainer = HBoxContainer.new()
		var txt: Label = Label.new()
		var val: Label = Label.new()
		var col: Color
		match get_meta("name"):
			"Ball": col = Color(0.0, 0.0, 255.0)
			"Box": col = Color(255.0, 0.0, 0.0)
			"cord": col = Color(0.0, 255.0, 0.0)
		txt.set("theme_override_colors/font_color", col)
		val.set("theme_override_colors/font_color", col)
		row.name = name + "_" + vname
		val.name =  "value"
		txt.name = "text"
		txt.text = row.name + " = "
		row.add_child(txt)
		row.add_child(val)
		row.visible = false
		get_parent().get_node("StatsView/ValuesDisplay").add_child(row)


func update_switches() -> void:
	show_vec_velocity = $"Menu-phyObj/MenuPanel/Vectors/VecVelocity".button_pressed
	show_vec_gravity = $"Menu-phyObj/MenuPanel/Vectors/VecGravity".button_pressed
	show_vec_reaction = $"Menu-phyObj/MenuPanel/Vectors/VecReaction".button_pressed

	show_val_velocity = $"Menu-phyObj/MenuPanel/Values/ValVelocity".button_pressed
	show_val_gravity = $"Menu-phyObj/MenuPanel/Values/ValGravity".button_pressed
	show_val_reaction = $"Menu-phyObj/MenuPanel/Values/ValReaction".button_pressed
	
	make_static = $"Menu-phyObj/MenuPanel/MakeStaticBtn".button_pressed


func throw(vector: Vector2):
	$RigidBody2D.apply_impulse(Vector2.ZERO, vector)
