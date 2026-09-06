extends AnimatedSprite2D

func move_forward(x,y):
	var original_position = position
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(x,y), 0.5)
	tween.tween_interval(0.2)
	tween.tween_property(self, "position", original_position, 0.5)
