extends Sprite2D
var start_x: float = 0.0
var max_x: float = 640.0

func _process(_delta: float) -> void:
	var player_x: float = $"../Player".position.x
	var filter: float = remap(player_x, start_x, max_x, 0.0, 1.0)
	filter = clamp(filter, 0.0, 1.0)
	modulate.g = 1.0 - filter
	modulate.b = 1.0 - filter
