extends AnimatedSprite2D

var backgrounds: Array = [
	"anemo_background",
	"hydro_background",
	"pyro_background",
	"dendro_background"
]

func _ready() -> void:
	play(backgrounds[Global.player_element])
