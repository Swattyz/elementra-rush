extends AnimatedSprite2D

var attacking: bool = false

func _ready() -> void:
	play("open mouth")

func dragon_attack():
	attacking = true
	play("attack")
	Audios.sopro_do_dragao()
	await animation_finished
	attacking = false

func taking_damage():
	$"../Slash".slashing()
	modulate = Color.LIGHT_GRAY
	await get_tree().create_timer(0.65).timeout
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

func dying():
	modulate = Color.DARK_GRAY
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(513, 400), 1.0)
	await tween.finished
	modulate = Color.WHITE

func reviving():
	modulate = Color.RED
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(513, 129), 1.0)
	await tween.finished
	modulate = Color.WHITE

func _on_animation_finished() -> void:
	play("idle")

func _on_timer_timeout() -> void:
	if attacking: return
	play("open mouth")
