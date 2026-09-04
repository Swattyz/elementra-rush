extends Label

func _ready() -> void:
	match Global.player_element:
		0:
			modulate = Color.AQUAMARINE
		1:
			modulate = Color.ROYAL_BLUE
		2:
			modulate = Color.ORANGE_RED
		3:
			modulate = Color.LAWN_GREEN
