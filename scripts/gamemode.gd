extends CheckButton

func _ready() -> void:
	_on_toggled(true)

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Global.gamemode = 1
		$Label.text = "Arduino"
	
	else:
		Global.gamemode = 0
		$Label.text = "Normal"
