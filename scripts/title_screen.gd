extends Control

func _ready() -> void:
	Global.tcp_client.put_8(ord('R'))
	Global.tcp_client.put_8(ord('\n'))
	pass

func _input(event: InputEvent) -> void:
	if event.is_action("up") or event.is_action("down") or event.is_action("left") or event.is_action("right"):
		var ui_event = InputEventAction.new()
		ui_event.pressed = true
		ui_event.action = "ui_accept"
		Input.parse_input_event(ui_event)
