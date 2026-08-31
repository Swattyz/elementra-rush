extends Node2D

var buttons: Control
var fight_button: TextureButton

var rng = RandomNumberGenerator.new()
var chance: float

var fight_qte_scene: PackedScene = preload("res://scenes/fight_qte.tscn")
var fight_qte

var fight_dialogue_scene: PackedScene = preload("res://scenes/fight_dialogue.tscn")
var fight_dialogue = fight_dialogue_scene.instantiate()
var unknown_icon: String = "res://object_sprites/unknown_identity_icon.png"
var player_icon: String = "res://player_sprites/anemo_walking_spritesheet.png"

var current_action: int = 0
var counter: int = 0

var dead: bool = false
var won: bool = false
var current_turn: int = 0
var player_hit_qte: bool = false

func _ready() -> void:
	rng.randomize()
	buttons = $FightHUD/Buttons
	fight_button = $FightHUD/Buttons/FightButton

func _process(_delta: float) -> void:
	if dead or won:
		if Input.is_action_just_pressed("confirm"):
			if TransitionScreen.transitioning:
				return
			TransitionScreen.transitioning = true
			TransitionScreen.transition()
			await TransitionScreen.on_transition_finished
			call_deferred("change_scene")
		return
	
	elif current_turn == 0:
		match current_action:
			1:
				if player_hit_qte:
					if counter == 0:
						fight_qte.queue_free()
						
						add_child(fight_dialogue)
						fight_dialogue.change_dialogue("...", "???", unknown_icon)
						if Global.player_qte == 0:
							fight_dialogue.change_text("...Errou o ataque...")
						elif Global.player_qte < 3:
							fight_dialogue.change_text("...Desferiu um poderoso golpe na criatura!")
						elif Global.player_qte < 7:
							fight_dialogue.change_text("...Obteve uma extrema perfomance e precisão no ataque e atingiu a criatura em cheio!")
						else:
							fight_dialogue.change_text("...Um acerto CRÍTICO na criatura!")
						$FightHUD/DragonHP.value -= Global.player_qte*3
						
						print("Player DMG D20: ",Global.player_qte)
						print("Player Damage: ",Global.player_qte*3,"\n")
						counter += 1
					
					elif counter == 1:
						var tween = create_tween()
						tween.tween_property($Enemy, "modulate", Color(0.5, 0.0, 0.0, 1.0), 0.0)
						tween.tween_interval(0.25)
						tween.tween_property($Enemy, "modulate", Color.WHITE, 0.0)
						counter += 1
						
					elif counter == 2:
						if Input.is_action_just_pressed("confirm"):
							current_action = 4
							player_hit_qte = false
							counter = 0
			2:
				pass
			3:
				match counter:
					0:
						if Input.is_action_just_pressed("confirm"):
							if chance >= 19:
								fight_dialogue.change_text("...Com um ótimo controle de seu corpo, obteve extremo sucesso na sua fuga.")
							elif chance == 18:
								fight_dialogue.change_text("...Você conseguiu fugir, covardemente.")
							elif chance == 17:
								fight_dialogue.change_text("...Por pouco, quase perdia um pé durante a fuga... Mas obteve sucesso, ou quase isso.")
							elif chance >= 10:
								fight_dialogue.change_text("...A tentativa falhou miseravelmente... Exatamente como um jantar de dragão, tentando fugir de seu destino.")
							elif chance > 2:
								fight_dialogue.change_text("...Você é impedido no meio de sua fútil tentativa e cai no chão.")
							else:
								fight_dialogue.change_text("...Terrivelmente, você tropeça na menor rocha possível, cai no chão e leva dano por isso... Não é seu dia de sorte.")
								counter += 1
						
					1:
						if Input.is_action_just_pressed("confirm"):
							if chance >= 17:
								if TransitionScreen.transitioning:
									return
									
								TransitionScreen.transitioning = true
								TransitionScreen.transition()
								await TransitionScreen.on_transition_finished
								call_deferred("change_scene")
							counter += 1
						
					2:
						print("Player RunAway D20: ",chance,"\n")
						counter += 1
						if chance <= 2:
							$FightHUD/PlayerHP.value -= 5
								
					_:
						counter = 0
						current_action = 4
			4:
				current_turn += 1
				current_action = 0
	
	elif current_turn == 1:
		match counter:
			0:
				chance = rng.randi_range(1,20)
				print("Dragon DMG D20: ",chance)
				fight_dialogue.change_text("O dragão furiosamente ataca!")
				counter += 1
			1:
				if Input.is_action_just_pressed("confirm"):
					if chance < 3:
						fight_dialogue.change_text("...O dragão errou o golpe!")
						chance = 0
					elif chance < 9:
						fight_dialogue.change_text("...A criatura desfere um golpe certeiro!")
					elif chance < 14:
						fight_dialogue.change_text("...A besta realiza um excelente ataque!")
					elif chance < 19:
						fight_dialogue.change_text("...A criatura dracônica avança em uma ofensiva letal!")
					elif chance == 20:
						fight_dialogue.change_text("...O dragão desfere um acerto PERFEITO!")
					counter += 1
					
					if chance == 0:
						counter = 7
			2:
				if Input.is_action_just_pressed("confirm"):
					fight_dialogue.change_text("Prepare-se para se defender!")
					counter += 1
			3:
				if Input.is_action_just_pressed("confirm"):
					remove_child(fight_dialogue)
					await get_tree().process_frame
					qte_start()
					counter += 1
			4:
				if player_hit_qte:
					fight_qte.queue_free()
					add_child(fight_dialogue)
					if Global.player_qte == 0:
						fight_dialogue.change_text("...Errou a defesa...")
					elif Global.player_qte < 3:
						fight_dialogue.change_text("...Foi capaz de bloquear uma parte razoável de dano!")
					elif Global.player_qte < 7:
						fight_dialogue.change_text("...Conseguiu uma excelente postura defensiva!")
					else:
						fight_dialogue.change_text("...Realizou uma defesa PERFEITA! Essa foi por pouco...")
					
					print("Dragon's DMG: ", chance*2,"\n")
					
					print("Player's Defense D20: ",Global.player_qte,"\n")
					print("Player's Defense Multiplier: ", (1 - (Global.player_qte/10)))
					print("Player's Reduced DMG: ", (chance * 2) - ((chance * 2) * (1 - (Global.player_qte/10))))
					chance = (chance * 2) * (1 - (Global.player_qte/10))
					
					if chance < 0: chance = 0
					counter += 1
			5:
				$FightHUD/PlayerHP.value -= chance
				print("Dragon's Real Damage: ", chance)
				counter += 1
			6:
				var tween = create_tween()
				tween.tween_property($Player, "modulate", Color(0.5, 0.0, 0.0, 1.0), 0.0)
				tween.tween_interval(0.25)
				tween.tween_property($Player, "modulate", Color.WHITE, 0.0)
				counter += 1
			7:
				if Input.is_action_just_pressed("confirm"):
					remove_child(fight_dialogue)
					$FightHUD.add_child(buttons)
					fight_button.grab_focus()
					counter += 1
			8:
				current_turn -= 1
				player_hit_qte = false
				counter = 0

func change_scene():
	get_tree().change_scene_to_file("res://scenes/ending.tscn")

func _on_fight_button_pressed() -> void:
	$FightHUD.remove_child(buttons)
	qte_start()
	current_action = 1

func qte_start():
	fight_qte = fight_qte_scene.instantiate()
	fight_qte.player_attacked.connect(_on_player_attacked)
	$FightHUD.add_child(fight_qte)

func _on_item_button_pressed() -> void:
	$FightHUD.remove_child(buttons)
	current_action = 2

func _on_run_button_pressed() -> void:
	$FightHUD.remove_child(buttons)
	add_child(fight_dialogue)
	fight_dialogue.change_text("...Você tentou achar uma brecha para fugir...")
	chance = rng.randi_range(1,20)
	chance = 1
	current_action = 3

func _on_player_hp_value_changed(value: float) -> void:
	if value == 0:
		dead = true
		fight_dialogue.change_dialogue("...Seu HP ficou baixo demais... Você está perdendo forças...","???",unknown_icon)

func _on_dragon_hp_value_changed(value: float) -> void:
	if value == 0:
		won = true
		fight_dialogue.change_dialogue("...O dragão mostrou-se muito fraco... Você venceu!","???",unknown_icon)

func _on_player_attacked():
	player_hit_qte = true
	
