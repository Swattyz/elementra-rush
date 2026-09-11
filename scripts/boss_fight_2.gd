extends Node2D

signal confirm_pressed

var buttons: Control
var fight_button: TextureButton

var rng = RandomNumberGenerator.new()
var chance: float

var fight_qte_scene: PackedScene = preload("res://scenes/fight_qte.tscn")
var fight_qte

var item_qte_scene: PackedScene = preload("res://scenes/item_qte.tscn")
var item_qte

var atk_bonus: float = 1
var def_bonus: float = 0

var cycles_run_def: int = 0
var cycles_run_atk: int = 0

var atk_buff_active: bool = false
var def_buff_active: bool = false

var fight_dialogue_scene: PackedScene = preload("res://scenes/fight_dialogue.tscn")
var fight_dialogue = fight_dialogue_scene.instantiate()
var unknown_icon: String = "res://object_sprites/unknown_identity_icon.png"
var player_icon: String = "res://player_sprites/anemo_walking_spritesheet.png"

var current_action: int = 0

var current_turn: int = 0

var dragon_phase: int = 0
var dmg: float = 0.0

var attacking_animations: Array = [
	"attacking anemo",
	"attacking hydro",
	"attacking pyro",
	"attacking dendro"
]

var blocking_animations: Array = [
	"blocking anemo",
	"blocking hydro",
	"blocking pyro",
	"blocking dendro"
]

var player_block_animation: String
var player_attack_animation: String

func _ready() -> void:
	rng.randomize()
	buttons = $FightHUD/Buttons
	fight_button = $FightHUD/Buttons/FightButton
	$ATKBuff.hide()
	$DEFBuff.hide()
	player_block_animation = blocking_animations[Global.player_element]
	player_attack_animation = attacking_animations[Global.player_element]
	$FightHUD/DamagePlayer.hide()
	$FightHUD/DamageDragon.hide()
	$FightHUD/DragonHP.max_value = 120
	$FightHUD/DragonHP.value = 120
	$FightHUD/DragonHP.texture_over = load("res://hud/over_player.png")
	$FightHUD/DragonHP.texture_progress = load("res://hud/progress_hp_player.png")
	
	while Global.ending == 0:
		if current_turn == 0:
			match current_action:
				1:
					await fight_qte.player_attacked
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
					dmg = Global.player_qte * (3+atk_bonus)
					
					await taking_damage($Enemy)
					await drop_health($FightHUD/DragonHP,dmg)
					
					print("Player QTE: ",Global.player_qte)
					print("Player Damage: ",dmg,"\n")
						
					if Global.player_qte > 0:
						$FightHUD/DamageDragon.text = str(int(dmg))
						$FightHUD/DamageDragon.show()
						await reappearing_effect($Enemy)
					
					await confirm_pressed
					$FightHUD/DamageDragon.hide()
					
					if $FightHUD/DragonHP.value == 0:
						await dragon_death()
						continue
					
					current_action = 4
				2:
					await item_qte.item_chose
					item_qte.queue_free()
					add_child(fight_dialogue)
					
					match Global.item_qte:
						"heal":
							fight_dialogue.change_text("...Conseguiu uma poção de cura e recuperou HP!")
							var tween = create_tween()
							tween.tween_property($Player, "modulate", Color(0.0, 0.65, 0.0, 1.0), 0.0)
							tween.tween_interval(0.35)
							tween.tween_property($Player, "modulate", Color.WHITE, 0.0)
							gain_health($FightHUD/PlayerHP,Global.item_value)
						"atk":
							fight_dialogue.change_text("...Conseguiu uma poção de aumento de dano por 3 turnos!")
							atk_bonus = Global.item_value
							atk_buff_active = true
							$ATKBuff.show()
							cycles_run_atk = 0
						"def":
							fight_dialogue.change_text("...Conseguiu uma poção de aumento de defesa por 3 turnos!")
							def_bonus = Global.item_value
							def_buff_active = true
							$DEFBuff.show()
							cycles_run_def = 0
						"none":
							fight_dialogue.change_text("...Não encontrou itens no inventário...")
					await get_tree().create_timer(0.5).timeout
					await confirm_pressed
					current_action = 4
				3:
					print("Player RunAway: ",chance)
					if $FightHUD/PlayerHP.value < 5:
						chance += 8
					elif $FightHUD/PlayerHP.value < 10:
						chance += 6
					elif $FightHUD/PlayerHP.value < 20:
						chance += 4
					elif $FightHUD/PlayerHP.value < 40:
						chance += 3
					elif $FightHUD/PlayerHP.value < 60:
						chance += 2
					elif $FightHUD/PlayerHP.value < 80:
						chance += 1
					if chance > 20: chance = 20
					
					await confirm_pressed
					
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
						
					if chance >= 17:
						Global.ending = 1
						break
					
					await confirm_pressed
					print("Player Real RunAway: ",chance,"\n")
					
					if chance <= 2:
						await drop_health($FightHUD/PlayerHP,5)
						
					current_action = 4
				4:
					if atk_buff_active or def_buff_active:
						if atk_buff_active:
							cycles_run_atk += 1
							if cycles_run_atk == 4:
								cycles_run_atk = 0
								atk_bonus = 1
								atk_buff_active = false
								$ATKBuff.hide()
								fight_dialogue.change_text("...Seu aumento de dano expirou!")
								await confirm_pressed
							
						if def_buff_active:
							cycles_run_def += 1
							if cycles_run_def == 5:
								cycles_run_def = 0
								def_bonus = 0
								def_buff_active = false
								$DEFBuff.hide()
								fight_dialogue.change_text("...Seu aumento de defesa expirou!")
								await confirm_pressed
								
					current_turn += 1
					current_action = 0
		
		elif current_turn == 1:
			chance = rng.randi_range(1,20)
			print("Dragon DMG D20: ",chance)
			fight_dialogue.change_text("O dragão furiosamente ataca!")
			await confirm_pressed
			if chance < 3:
				fight_dialogue.change_text("...O dragão errou o golpe!")
				chance = 0
			elif chance < 9:
				fight_dialogue.change_text("...A criatura vai desferir um golpe certeiro!")
			elif chance < 14:
				fight_dialogue.change_text("...A besta realizará um excelente ataque!")
			elif chance < 19:
				fight_dialogue.change_text("...A criatura dracônica avança em uma ofensiva letal!")
			elif chance == 20:
				fight_dialogue.change_text("...O dragão lhe atingirá com um acerto PERFEITO!")
			
			await confirm_pressed
			
			if chance > 0:
				fight_dialogue.change_text("Prepare-se para se defender!")
				await confirm_pressed
				
				remove_child(fight_dialogue)
				await get_tree().process_frame
				
				qte_start()
				await fight_qte.qte_has_started
				$Enemy.move_forward(300,128)
				$Player.play(player_block_animation)
				await fight_qte.player_attacked
				
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
				
				print("Dragon's DMG: ", chance*2.5,"\n")
				
				print("Player's Defense D20: ",Global.player_qte,"\n")
				print("Player's Defense Multiplier: ", (1 - ((Global.player_qte/10) + def_bonus)))
				print("Player's Reduced DMG: ", (chance * 2.5) * (1 - ((Global.player_qte/10) + def_bonus)))
				chance = (chance * 2.5) * (1 - ((Global.player_qte/10) + def_bonus))
				
				if chance < 0: chance = 0
				if dragon_phase == 1: chance = chance * 1.2
				
				print("Dragon's Real Damage: ", chance,"\n")
				if Global.player_qte > 0:
					var tween = create_tween()
					tween.tween_property($Player, "modulate", Color(0.0, 0.0, 0.65, 1.0), 0.0)
					tween.tween_interval(0.1)
					tween.tween_property($Player, "modulate", Color.WHITE, 0.0)
					tween.tween_interval(0.1)
					tween.tween_property($Player, "modulate", Color(0.0, 0.0, 0.65, 1.0), 0.0)
					tween.tween_interval(0.25)
					tween.tween_property($Player, "modulate", Color.WHITE, 0.0)
					await tween.finished
				else:
					await taking_damage($Player)
				
				await drop_health($FightHUD/PlayerHP,chance)
				
				$FightHUD/DamagePlayer.text = str(int(chance))
				$FightHUD/DamagePlayer.show()
				
				if chance > 0:
					await reappearing_effect($Player)
				
				if $FightHUD/PlayerHP.value == 0:
					await confirm_pressed
					fight_dialogue.change_dialogue("...Seu HP ficou baixo demais... Você está perdendo forças...","???",unknown_icon)
					Global.ending = 2
					continue
				
				await confirm_pressed
				remove_child(fight_dialogue)
				$FightHUD.add_child(buttons)
				fight_button.grab_focus()
				current_turn -= 1
				$FightHUD/DamagePlayer.hide()
				
		await get_tree().process_frame
	
	fight_end()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("confirm"): confirm_pressed.emit()

func change_scene():
	get_tree().change_scene_to_file("res://scenes/aftermath.tscn")

func _on_fight_button_pressed() -> void:
	$FightHUD.remove_child(buttons)
	qte_start()
	await fight_qte.qte_has_started
	$Player.move_forward(360,186)
	$Player.play(player_attack_animation)
	current_action = 1

func qte_start():
	fight_qte = fight_qte_scene.instantiate()
	$FightHUD.add_child(fight_qte)

func _on_item_button_pressed() -> void:
	$FightHUD.remove_child(buttons)
	item_qte_start()
	current_action = 2

func item_qte_start():
	item_qte = item_qte_scene.instantiate()
	$FightHUD.add_child(item_qte)

func _on_run_button_pressed() -> void:
	$FightHUD.remove_child(buttons)
	add_child(fight_dialogue)
	fight_dialogue.change_text("...Você tentou achar uma brecha para fugir...")
	chance = rng.randi_range(1,20)
	current_action = 3

func _on_player_hp_value_changed(value: float) -> void:
	if value < 25:
		$FightHUD/PlayerHP.tint_progress = Color(1.85, 0.0, 0.0, 1.0)
	elif value < 50:
		$FightHUD/PlayerHP.tint_progress = Color(1.95, 0.7, 0.0, 1.0)
	else:
		$FightHUD/PlayerHP.tint_progress = Color.WHITE

func dragon_death():
	if dragon_phase == 0:
		dragon_phase = 1
		current_action = 4
		await second_phase()
		
	elif dragon_phase == 1:
		Global.ending = 3
		fight_dialogue.change_dialogue("...O dragão mostrou-se muito fraco... Você venceu!","???",unknown_icon)

func second_phase():
	fight_dialogue.change_text("...O dragão caiu fraco no magma fervente... Porém voltou da morte?!")
	await confirm_pressed
	fight_dialogue.change_text("Ele parece irritado... A defesa e ataque do dragão subiram!")
	await confirm_pressed
	$FightHUD/DamagePlayer.modulate = Color.RED
	$FightHUD/DragonHP.max_value = 150
	$FightHUD/DragonHP.texture_progress = load("res://hud/progress_hp_enemy.png")
	$FightHUD/DragonHP.texture_over = load("res://hud/over_dragon.png")
	
	await gain_health($FightHUD/DragonHP,150)
	
	var tween = create_tween()
	tween.tween_property($Enemy, "modulate", Color(1.0, 0.0, 0.0, 1.0), 0.0)
	tween.tween_interval(0.5)
	tween.tween_property($Enemy, "modulate", Color.WHITE, 0.0)
	await tween.finished

func taking_damage(a):
	var tween = create_tween()
	tween.tween_property(a, "modulate", Color(0.65, 0.0, 0.0, 1.0), 0.0)
	tween.tween_interval(0.1)
	tween.tween_property(a, "modulate", Color.WHITE, 0.0)
	tween.tween_interval(0.1)
	tween.tween_property(a, "modulate", Color(0.65, 0.0, 0.0, 1.0), 0.0)
	tween.tween_interval(0.25)
	tween.tween_property(a, "modulate", Color.WHITE, 0.0)

func reappearing_effect(a):
	var tween = create_tween()
	tween.tween_property(a, "visible", false, 0.0)
	tween.tween_interval(0.1)
	tween.tween_property(a, "visible", true, 0.0)
	tween.tween_interval(0.1)
	tween.tween_property(a, "visible", false, 0.0)
	tween.tween_interval(0.25)
	tween.tween_property(a, "visible", true, 0.0)

func drop_health(bar, damage):
	var new_health = bar.value - damage
	if new_health < 0: new_health = 0
	
	var tween = create_tween()
	tween.tween_property(bar, "value", new_health, 1.0)
	await tween.finished

func gain_health(bar, health):
	var new_health = bar.value + health
	if new_health > bar.max_value: new_health = bar.max_value
	
	var tween = create_tween()
	tween.tween_property(bar, "value", new_health, 1.0)
	await tween.finished

func fight_end():
	await confirm_pressed
	if TransitionScreen.transitioning: return
	TransitionScreen.transitioning = true
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	call_deferred("change_scene")
