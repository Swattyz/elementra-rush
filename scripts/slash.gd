extends AnimatedSprite2D

func slashing():
	show()
	match Global.player_element:
		0:
			play("anemo")
		1:
			play("hydro")
		2:
			play("pyro")
		3:
			play("dendro")
	await animation_finished
	hide()
