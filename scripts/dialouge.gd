class_name dialog extends Node

static func atk_miss():
	const STRS = [
		"O Dragão Desviou do golpe!",
		"Sua espada nem arranhou as escamas dele",
		"Medo controla voce por um momento",
		"...Errou o ataque...",
	]
	return STRS.pick_random()

static func atk_okay():
	const STRS = [
		"Desferiu um poderoso golpe na criatura!",
		"Desferiu um poderoso golpe na criatura!",
		"a pata do dragão levou um golpe",
		"a pata do dragão levou um golpe",
		"O Dragão não conseguiu desviar",
		"O Dragão não conseguiu desviar",
		"O Dragão bateu em cheio em uma parede",
	]
	return STRS.pick_random()

static func atk_great():
	const STRS = [
		"...Obteve uma extrema perfomance e precisão no ataque e atingiu a criatura em cheio!",
		"Pensando rápido, você ataca o ponto vulnerável do dragão!",
		"Acerto em cheio na pata do dragão",
	]
	return STRS.pick_random()

static func atk_crit():
	return "...Um acerto CRÍTICO na criatura!"
