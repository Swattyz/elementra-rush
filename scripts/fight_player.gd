extends AnimatedSprite2D

var sword_drawing_animations = [
	"sword drawing anemo",
	"sword drawing hydro",
	"sword drawing pyro",
	"sword drawing dendro"
]

var sword_idle_animations = [
	"sword idle anemo",
	"sword idle hydro",
	"sword idle pyro",
	"sword idle dendro"
]

func _ready() -> void:
	play(sword_drawing_animations[Global.player_element])

func _on_animation_finished() -> void:
	play(sword_idle_animations[Global.player_element])

func move_forward(x,y):
	var original_position = position
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(x,y), 0.5)
	tween.tween_interval(0.2)
	tween.tween_property(self, "position", original_position, 0.5)
