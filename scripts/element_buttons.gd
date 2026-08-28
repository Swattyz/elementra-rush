extends TextureButton

func _ready():
	grab_focus()

func _on_mouse_entered() -> void:
	modulate = Color(1.1, 1.1, 1.1, 1.0)
	selecting_text(1)

func _on_focus_entered() -> void:
	modulate = Color(1.1, 1.1, 1.1, 1.0)
	selecting_text(1)

func _on_mouse_exited() -> void:
	modulate = Color(0.7, 0.7, 0.7, 1.0)
	selecting_text(0)

func _on_focus_exited() -> void:
	modulate = Color(0.7, 0.7, 0.7, 1.0)
	selecting_text(0)

func _on_button_down() -> void:
	if TransitionScreen.transitioning:
		return
	
	TransitionScreen.transitioning = true
	modulate = Color(0.5, 0.5, 0.5, 1.0)
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	call_deferred("change_scene")

func _on_button_up() -> void:
	modulate = Color(1.1, 1.1, 1.1, 1.0)

func change_scene():
	get_tree().change_scene_to_file("res://scenes/forest.tscn")

func selecting_text(mode):
	match name:
		"ElementAnemo":
			if mode == 0:
				$Air.texture = load("res://object_sprites/unselected_text_anemo.png")
			elif mode == 1:
				$Air.texture = load("res://object_sprites/selected_text_anemo.png")
		"ElementHydro":
			if mode == 0:
				$Water.texture = load("res://object_sprites/unselected_text_hydro.png")
			elif mode == 1:
				$Water.texture = load("res://object_sprites/selected_text_hydro.png")
		"ElementPyro":
			if mode == 0:
				$Fire.texture = load("res://object_sprites/unselected_text_pyro.png")
			elif mode == 1:
				$Fire.texture = load("res://object_sprites/selected_text_pyro.png")
		"ElementDendro":
			if mode == 0:
				$Nature.texture = load("res://object_sprites/unselected_text_dendro.png")
			elif mode == 1:
				$Nature.texture = load("res://object_sprites/selected_text_dendro.png")
