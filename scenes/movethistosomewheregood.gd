extends Control

func _input(event: InputEvent) -> void:
	if event.is_action("up") or event.is_action("down") or event.is_action("left") or event.is_action("right"):
		var ui_event = InputEventAction.new()
		if event.is_action("up"):
			ui_event.action = "ui_accept"
			ui_event.pressed = event.is_action_pressed("up")
		elif event.is_action("down"):
			ui_event.action = "ui_down"
			ui_event.pressed = event.is_action_pressed("down")
		elif event.is_action("left"):
			ui_event.action = "ui_left"
			ui_event.pressed = event.is_action_pressed("left")
		elif event.is_action("right"):
			ui_event.action = "ui_right"
			ui_event.pressed = event.is_action_pressed("right")
		Input.parse_input_event(ui_event)
