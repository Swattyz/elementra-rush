extends Sprite2D

func _ready() -> void:
	hide()

func use_item(item):
	match item:
		"atk":
			texture = load("res://object_sprites/potions/atk.png")
		"def":
			texture = load("res://object_sprites/potions/def.png")
		"heal":
			texture = load("res://object_sprites/potions/heal.png")
	show()
	
	var original_position = position
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(167, 35), 0.5)
	tween.tween_property(self, "modulate", Color(1.5, 1.5, 1.5, 0.0), 0.5)
	await tween.finished
	hide()
	modulate = Color.WHITE
	position = original_position
