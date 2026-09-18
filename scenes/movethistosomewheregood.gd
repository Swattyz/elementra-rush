extends Control

func _input(event: InputEvent) -> void:
	if !Global.arduino: return
	if event.is_action("up") or event.is_action("down") or event.is_action("left") or event.is_action("right"):
		var ui_event = InputEventAction.new()
		ui_event.pressed = event.is_action_pressed(event.action)
		if event.is_action("up"):
			ui_event.action = "ui_accept"
		elif event.is_action("down"):
			ui_event.action = "ui_down"
		elif event.is_action("left"):
			ui_event.action = "ui_left"
		elif event.is_action("right"):
			ui_event.action = "ui_right"
		Input.parse_input_event(ui_event)
