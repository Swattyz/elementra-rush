extends Button

func _ready():
	grab_focus()

func _on_mouse_entered() -> void:
	modulate = Color(1.5, 1.5, 1.5, 1.0)

func _on_mouse_exited() -> void:
	modulate = Color.WHITE

func _on_button_down() -> void:
	Global.coming_back = false
	Audios.click()
	
	if TransitionScreen.transitioning:
		return
	
	TransitionScreen.transitioning = true
	modulate = Color(0.5, 0.5, 0.5, 1.0)
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	call_deferred("change_scene")

func change_scene():
	get_tree().change_scene_to_file("res://scenes/element_choose.tscn")

func _on_button_up() -> void:
	modulate = Color(1.2, 1.2, 1.2, 1.0)

func _input(event: InputEvent) -> void:
	if event.is_action("up") or event.is_action("down") or event.is_action("left") or event.is_action("right"):
		var ui_event = InputEventAction.new()
		ui_event.pressed = true
		ui_event.action = "ui_accept"
		Input.parse_input_event(ui_event)
