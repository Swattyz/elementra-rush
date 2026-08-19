extends TextureButton

func _ready():
	grab_focus()

func _on_mouse_entered() -> void:
	modulate = Color(1.5, 1.5, 1.5, 1.0)

func _on_mouse_exited() -> void:
	modulate = Color.WHITE

func _on_button_down() -> void:
	disabled = true
	modulate = Color(0.5, 0.5, 0.5, 1.0)
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	call_deferred("change_scene")

func change_scene():
	get_tree().change_scene_to_file("res://scenes/element_choose.tscn")

func _on_button_up() -> void:
	modulate = Color(1.2, 1.2, 1.2, 1.0)
