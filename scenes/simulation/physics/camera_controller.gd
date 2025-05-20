extends Camera2D

var zoom_target: Vector2
var zoom_speed: float = 5
var mouse_p1: Vector2
var mouse_p2: Vector2
var mouse_drag_p1: Vector2
var camera_drag_p1: Vector2
var dragging: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			mouse_p1 = get_global_mouse_position()
			zoom *= 1.05
			mouse_p2 = get_global_mouse_position()
			position += mouse_p1 - mouse_p2
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			mouse_p1 = get_global_mouse_position()
			zoom *= 0.95
			mouse_p2 = get_global_mouse_position()
			position += mouse_p1 - mouse_p2
		elif cursor_manager.cursor_mode == "pan" and event.button_index == MOUSE_BUTTON_LEFT:
			if !dragging:
				mouse_drag_p1 =  get_viewport().get_mouse_position()
				camera_drag_p1 = position
				dragging = true
			if dragging:
				var move_vec: Vector2 = get_viewport().get_mouse_position() - mouse_drag_p1
				position += camera_drag_p1 - move_vec * 1/zoom.x
		
		#dragging = false


func mouse_zoom(event) -> void:
	pass


func pan() -> void:
	pass
	
