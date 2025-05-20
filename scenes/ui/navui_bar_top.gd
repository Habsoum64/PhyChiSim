extends Control


func _on_menu_button_button_down() -> void:
	get_node("/root/Navui/NavuiSidebar").visible = !get_node("/root/Navui/NavuiSidebar").visible
