extends RigidBody2D

@onready var normal_force_visuals = $NormalForceVectors # A Node2D or container node

var contact_normals: Array[Dictionary] = []

func _integrate_forces(state: PhysicsDirectBodyState2D):
	contact_normals.clear()

	var contact_count = state.get_contact_count()
	for i in range(contact_count):
		var local_pos = state.get_contact_local_position(i)
		var world_pos = to_global(local_pos)
		var normal = state.get_contact_local_normal(i).normalized()

		# Approximate a force magnitude (optional)
		var normal_magnitude = linear_velocity.dot(normal)
		var force_vector = -normal * normal_magnitude

		contact_normals.append({
			"position": world_pos,
			"vector": force_vector
		})
