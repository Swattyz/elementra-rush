extends CharacterBody2D
var direction: Vector2 = Vector2(0,0)
var speed: int = 125

func _physics_process(_delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
