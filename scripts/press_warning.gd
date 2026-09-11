extends ColorRect

func _on_timer_timeout() -> void:
	var tween = create_tween()
	tween.tween_property(self, "visible", false, 0.0)
	tween.tween_interval(0.2)
	tween.tween_property(self, "visible", true, 0.0)
