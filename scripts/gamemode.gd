extends CheckButton

func _ready() -> void:
	button_pressed = true
	hide()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("show_gamemode"):
		show()
	
	elif Input.is_action_just_pressed("hide_gamemode"):
		hide()

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Global.gamemode = 1
		$Label.text = "Arduino"
	
	else:
		Global.gamemode = 0
		$Label.text = "Normal"
