extends Node

var player_element: int = 0
var player_qte: float = 0
var item_qte: String = "none"
var item_value: float = 0
var ending: int = 0
var coming_back: bool = false

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

	if event.is_action_pressed("toggle fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

var tcp_client: StreamPeerTCP
var polling_movement: bool = true

func _ready() -> void:
	tcp_client = StreamPeerTCP.new()
	var ok = tcp_client.connect_to_host("0.0.0.0", 8080)
	tcp_client.poll()
	tcp_client.set_no_delay(true)
	print("ok is: ", ok)
	pass

func _process(delta: float) -> void:
	if !polling_movement:
		return
	
	if tcp_client.get_available_bytes() <= 0:
		return
	var size = tcp_client.get_u32()
	var result = tcp_client.get_data(size)
	var error = result[0]
	var data = result[1]
	print(data)
	
	# key was just PRESSED
	if data[0] == 75:
		var event = InputEventAction.new()
		event.pressed = true
		if data[1] == 85: # U
			event.action = "up"
			Input.action_press("up")
		elif data[1] == 68: # D
			event.action = "down"
			Input.action_press("down")
		elif data[1] == 82: # R
			event.action = "right"
			Input.action_press("right")
		elif data[1] == 76: # L
			event.action = "left"
			Input.action_press("left")
		Input.parse_input_event(event)
	# key was just RELEASED
	elif data[0] == 82:
		var event = InputEventAction.new()
		event.pressed = false
		if data[1] == 85: # U
			event.action = "up"
			Input.action_release("up")
		elif data[1] == 68: # D
			event.action = "down"
			Input.action_release("down")
		elif data[1] == 82: # R
			event.action = "right"
			Input.action_release("right")
		elif data[1] == 76: # L
			event.action = "left"
			Input.action_release("left")
		Input.parse_input_event(event)
	
	
	pass
