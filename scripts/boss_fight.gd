extends Node2D

var buttons: Control
var fight_button: TextureButton

var rng = RandomNumberGenerator.new()
var chance: int

var fight_qte_scene: PackedScene = preload("res://scenes/fight_qte.tscn")
var fight_qte_instance = (fight_qte_scene).instantiate()

var fight_dialogue_scene: PackedScene = preload("res://scenes/fight_dialogue.tscn")
var fight_dialogue = fight_dialogue_scene.instantiate()
var unknown_icon: String = "res://object_sprites/unknown_identity_icon.png"
var player_icon: String = "res://player_sprites/anemo_walking_spritesheet.png"

var current_action: int = 0
var counter: int = 0

var dead: bool = false
var current_turn: int = 0

func _ready() -> void:
	rng.randomize()
	buttons = $FightHUD/Buttons
	fight_button = $FightHUD/Buttons/FightButton

func _process(_delta: float) -> void:
	if dead:
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
				pass
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
						print("Player: ",chance)
						counter += 1
						if chance <= 2:
							$FightHUD/PlayerHP.value -= 5
								
					_:
						current_turn += 1
						counter = 0
						current_action = 0
	
	elif current_turn == 1:
		if counter == 0:
			chance = rng.randi_range(1,20)
			counter += 1
			print("Dragão: ",chance)
			fight_dialogue.change_text("O dragão furiosamente ataca!")
			
		if Input.is_action_just_pressed("confirm"):
			match counter:
				1:
					fight_dialogue.change_text("Ele desfere um golpe com suas garras!")
					$FightHUD/PlayerHP.value -= chance
					counter += 1
				2:
					remove_child(fight_dialogue)
					$FightHUD.add_child(buttons)
					fight_button.grab_focus()
					counter += 1
				3:
					current_turn -= 1
					counter = 0

func change_scene():
	get_tree().change_scene_to_file("res://scenes/ending.tscn")

func _on_fight_button_pressed() -> void:
	$FightHUD.remove_child(buttons)
	current_action = 1

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
	if $FightHUD/PlayerHP.value == 0:
		dead = true
		fight_dialogue.change_dialogue("...Seu HP ficou baixo demais... Você está perdendo forças...","???",unknown_icon)
