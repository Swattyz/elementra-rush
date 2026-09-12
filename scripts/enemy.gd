extends AnimatedSprite2D

func move_forward(x,y):
	var original_position = position
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(x,y), 0.5)
	tween.tween_interval(0.2)
	tween.tween_property(self, "position", original_position, 0.5)

func taking_damage():
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(0.65, 0.0, 0.0, 1.0), 0.0)
	tween.tween_interval(0.1)
	tween.tween_property(self, "modulate", Color.WHITE, 0.0)
	tween.tween_interval(0.1)
	tween.tween_property(self, "modulate", Color(0.65, 0.0, 0.0, 1.0), 0.0)
	tween.tween_interval(0.25)
	tween.tween_property(self, "modulate", Color.WHITE, 0.0)

func reappearing_effect():
	var tween = create_tween()
	tween.tween_property(self, "visible", false, 0.0)
	tween.tween_interval(0.1)
	tween.tween_property(self, "visible", true, 0.0)
	tween.tween_interval(0.1)
	tween.tween_property(self, "visible", false, 0.0)
	tween.tween_interval(0.25)
	tween.tween_property(self, "visible", true, 0.0)
