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

func taking_damage():
	Audios.sopro_do_dragao()
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
	Audios.dano()

func blocking_effect():
	Audios.sopro_do_dragao()
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(0.0, 0.0, 0.65, 1.0), 0.0)
	tween.tween_interval(0.1)
	tween.tween_property(self, "modulate", Color.WHITE, 0.0)
	tween.tween_interval(0.1)
	tween.tween_property(self, "modulate", Color(0.0, 0.0, 0.65, 1.0), 0.0)
	tween.tween_interval(0.25)
	tween.tween_property(self, "modulate", Color.WHITE, 0.0)
	await tween.finished

func heal_effect():
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(0.0, 1.0, 0.0, 1.0), 0.0)
	Audios.cura()
	tween.tween_interval(1.0)
	tween.tween_property(self, "modulate", Color.WHITE, 0.0)

func atk_effect():
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1.0, 0.0, 0.0, 1.0), 0.0)
	Audios.item()
	tween.tween_interval(0.35)
	tween.tween_property(self, "modulate", Color.WHITE, 0.0)

func def_effect():
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(0.0, 0.7, 1.0, 1.0), 0.0)
	Audios.item()
	tween.tween_interval(0.35)
	tween.tween_property(self, "modulate", Color.WHITE, 0.0)

func dying():
	modulate = Color.DARK_GRAY
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(140, 500), 1.0)
	await tween.finished
	modulate = Color.WHITE
