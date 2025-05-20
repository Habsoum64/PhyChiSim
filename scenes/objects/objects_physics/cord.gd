extends InteractiveObject

#@onready var rigidbody = $RigidBody2D
#@onready var collision_shape = rigidbody.get_node("CollisionShape2D")
@onready var segment = SegmentShape2D.new()
@onready var line_a = $RigidBody2D/Line2D.add_point(object_spawner.last_spawn_pos)
var shape_set: bool = false
var start_pos: Vector2
# var set_clicks: int = 1

func _ready() -> void:
	'''
	start_pos = rigidbody.global_position
	# Create the segment manually
	segment.a = start_pos
	segment.b = start_pos
	collision_shape.shape = segment
	'''

'''
func _process(delta: float) -> void:
	if !shape_set:
		segment = collision_shape.shape as SegmentShape2D
		segment.a = start_pos
		segment.b = get_global_mouse_position()
		# NOW reassign to refresh
		collision_shape.shape = segment
		
		if Input.is_action_just_pressed("ui_select"):
			shape_set = true
			rigidbody.freeze = true
'''

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !shape_set:
		segment.set_b(get_global_mouse_position())
		var ev = InputEvent
		if ev is InputEventMouseButton:
			if ev.is_pressed():
				shape_set = true
