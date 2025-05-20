extends RigidBody2D

#@onready var vector_velocity = get_parent().get_node("Vectors/Velocity")
#@onready var vector_gravity = get_parent().get_node("Vectors/Gravity")
@onready var vector_reaction = get_parent().get_node("Vectors/Reaction")
#@onready var vector_tension = get_parent().get_node("Vectors/Tension")

var contact_normals: Array = []


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	contact_normals.clear()
	var count: int = get_contact_count()
	for i in range(count):
		var local_pos: Vector2 = state.get_contact_local_position(i)
		var world_pos: Vector2 = to_global(local_pos)
		var normal = state.get_contact_local_normal(i).normalized()
		var normal_magnitude: float = linear_velocity.dot(normal)
		var force_vector: Vector2 = normal * normal_magnitude
		contact_normals.append({
			"pos": world_pos,
			"vector": force_vector
		})


func _process(delta: float) -> void:	
	if get_contact_count() > 0 and get_parent().show_vec_reaction:
		show_reaction()


func show_reaction() -> void:
	var adjusted_reaction: Vector2 = contact_normals[contact_normals.size() - 1]["vector"]
	vector_reaction.clear_points()
	vector_reaction.add_point(Vector2(0, 0))
	vector_reaction.add_point(adjusted_reaction)
