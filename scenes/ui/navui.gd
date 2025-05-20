extends Control


func clear_page() -> void:
	if $HBoxContainer/ScrollView.get_child_count() > 0:
		for nod in $HBoxContainer/ScrollView.get_child(0).get_children():
			nod.queue_free()
