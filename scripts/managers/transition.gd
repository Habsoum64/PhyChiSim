extends Node

@onready var color_rect: ColorRect = $ColorRect
@onready var current_scene = get_tree().current_scene

func _ready() -> void:
	color_rect.modulate.a = 0 # Start fully transparent

func fade_out(target_scene: String):
	current_scene.visible = false
	color_rect.modulate.a = 1 # Full opacity
	await get_tree().create_timer(1).timeout
	scene_manager.load_scene_direct(target_scene)
	fade_in()
	queue_free()

func fade_in():
	color_rect.modulate.a = 0 # Fade back to transparency
