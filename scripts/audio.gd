extends AudioStreamPlayer

func acerto():
	volume_db = +14.0
	stream = load("res://sfx/combat/acerto.wav")
	play()

func barra_de_reacao():
	volume_db = +17.0
	stream = load("res://sfx/combat/barra_de_reação.wav")
	play()

func cura():
	volume_db = -6.0
	stream = load("res://sfx/combat/cura.wav")
	play()

func dano():
	volume_db = -18.0
	stream = load("res://sfx/combat/dano.wav")
	play()

func erro():
	volume_db = +4.0
	stream = load("res://sfx/combat/erro.wav")
	play()

func item():
	volume_db = +10.0
	stream = load("res://sfx/combat/item.wav")
	play()

func sopro_do_dragao():
	volume_db = +7.0
	stream = load("res://sfx/combat/sopro_do_dragão.wav")
	play()

func falha():
	volume_db = -18.0
	stream = load("res://sfx/ui/falha.wav")
	play()

func click():
	volume_db = -15.0
	stream = load("res://sfx/ui/click.wav")
	play()

func player_dialogue():
	volume_db = +5.0
	stream = load("res://sfx/dialogue/diálogo_mc.wav")
	play()

func enemy_dialogue():
	volume_db = +7.0
	stream = load("res://sfx/dialogue/diálogo_dragão.wav")
	play()
