extends CanvasLayer

@onready var buttons: Array[Button] = [
	$MenuPanel/Vectors/VecVelocity, 
	$MenuPanel/Vectors/VecGravity, 
	$MenuPanel/Vectors/VecReaction, 
	$MenuPanel/Values/ValVelocity, 
	$MenuPanel/Values/ValGravity, 
	$MenuPanel/Values/ValReaction,
	$MenuPanel/MakeStaticBtn
]


func _ready() -> void:
	$MenuPanel/Vectors/VecVelocity.button_pressed = get_parent().show_vec_velocity
	$MenuPanel/Vectors/VecGravity.button_pressed = get_parent().show_vec_gravity
	$MenuPanel/Vectors/VecReaction.button_pressed = get_parent().show_vec_reaction
	$MenuPanel/Values/ValVelocity.button_pressed = get_parent().show_val_velocity
	$MenuPanel/Values/ValGravity.button_pressed = get_parent().show_val_gravity
	$MenuPanel/Values/ValReaction.button_pressed = get_parent().show_val_reaction
	$MenuPanel/MakeStaticBtn.button_pressed = get_parent().get_node("RigidBody2D").freeze


func _on_close_btn_pressed() -> void:
	var pnode = get_node("/root/PhySim")
	if pnode.show_stats:
		get_node("/root/PhySim/StatsView").show()
	hide()
	#get_parent().show_ctx_menu = false


func _on_button_toggled(button: Button, toggled_on: bool) -> void:
	button.button_pressed = toggled_on


func make_connections():
	for button in buttons:
		button.connect("toggled", Callable(_on_button_toggled).bind(button))
