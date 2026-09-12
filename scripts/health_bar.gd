extends TextureProgressBar

func _ready() -> void:
	if name == "PlayerHP":
		max_value = 100
		value = 100
	else:
		max_value = 120
		value = 120
		texture_over = load("res://hud/over_player.png")
		texture_progress = load("res://hud/progress_hp_player.png")

func drop_health(damage):
	var new_health = value - damage
	if new_health < 0: new_health = 0
	
	var tween = create_tween()
	tween.tween_property(self, "value", new_health, 1.0)
	await tween.finished

func gain_health(health):
	var new_health = value + health
	if new_health > max_value: new_health = max_value
	
	var tween = create_tween()
	tween.tween_property(self, "value", new_health, 1.0)
	await tween.finished

func _on_value_changed(_value: float) -> void:
	if value < 25:
		tint_progress = Color(1.85, 0.0, 0.0, 1.0)
	elif value < 50:
		tint_progress = Color(1.95, 0.7, 0.0, 1.0)
	else:
		tint_progress = Color.WHITE

func dragon_second_phase():
	max_value = 150
	texture_progress = load("res://hud/progress_hp_enemy.png")
	texture_over = load("res://hud/over_dragon.png")
	await gain_health(150)
