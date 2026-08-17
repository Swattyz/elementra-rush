extends CharacterBody2D
var direction: Vector2 = Vector2(0,0)
var speed: int = 100
var walking_animations = ["anemo_walk", "hydro_walk", "pyro_walk", "dendro_walk"]
var idle_animations = ["anemo_idle", "hydro_idle", "pyro_idle", "dendro_idle"]
var walk_animation: String
var idle_animation: String

func _ready():
	var index: int = Global.player_element
	walk_animation = walking_animations[index]
	idle_animation = idle_animations[index]

func _physics_process(_delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	if direction.x or direction.y:
		$AnimatedSprite2D.play(walk_animation)
		if direction.x < 0:
			$AnimatedSprite2D.flip_h = true
		elif direction.x > 0:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play(idle_animation)
