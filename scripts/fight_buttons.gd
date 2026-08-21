extends TextureButton

func _ready():
	grab_focus()

func _on_mouse_entered() -> void:
	modulate = Color(1.5, 1.5, 1.5, 1.0)

func _on_focus_entered() -> void:
	modulate = Color(1.5, 1.5, 1.5, 1.0)

func _on_mouse_exited() -> void:
	modulate = Color.WHITE

func _on_focus_exited() -> void:
	modulate = Color.WHITE

func _on_button_down() -> void:
	modulate = Color(0.5, 0.5, 0.5, 1.0)

func _on_button_up() -> void:
	modulate = Color(1.5, 1.5, 1.5, 1.0)
