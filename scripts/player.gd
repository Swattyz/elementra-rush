extends Node2D
var direction: Vector2 = Vector2(0,0)
var speed: int = 15

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	position += direction * speed
