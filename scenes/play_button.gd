extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_mouse_entered() -> void:
	modulate = Color(1.2, 1.2, 1.2, 1.0)

func _on_mouse_exited() -> void:
	modulate = Color.WHITE

func _on_button_down() -> void:
	modulate = Color(0.7, 0.7, 0.7, 1.0)
	call_deferred("change_scene")

func change_scene():
	get_tree().change_scene_to_file("res://scenes/element_choose.tscn")

func _on_button_up() -> void:
	modulate = Color(1.2, 1.2, 1.2, 1.0)
