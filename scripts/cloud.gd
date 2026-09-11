extends Sprite2D

@export var speed: float = 30.0

func _ready() -> void:
	randomize()
	
	scale = Vector2(randf_range(0.4, 0.9),randf_range(0.5, 0.9))
	
	if randi_range(1,2) == 1: flip_h = true

func _process(delta: float) -> void:
	position.x -= speed * delta

	if position.x < -texture.get_width():
		queue_free()
