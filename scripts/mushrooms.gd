extends Node2D

func _process(_delta: float) -> void:
	if $"../../Player".position.x >= 420:
		var tween = create_tween()
		tween.tween_property(self, "modulate", Color(1.5, 1.5, 1.5, 0.0), 0.8)
		await tween.finished
		queue_free()
