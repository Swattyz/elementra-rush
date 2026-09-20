extends AnimatedSprite2D

func _on_timer_timeout() -> void:
	play("open mouth")

func _on_animation_finished() -> void:
	play("idle")
