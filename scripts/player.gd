extends Node2D
var direction: Vector2 = Vector2(0,0)
var speed: int = 15

func _process(_delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	position += direction * speed
