extends Node2D
var character_nearby: bool = false
var character_never_entered: bool = true
var dialogue_box: PackedScene = preload("res://scenes/dialogue_box.tscn")
var counter: int = 0
var unknown: String = "res://object_sprites/unknown_identity_icon.png"
var player: String
var started_dialogue: bool = false
var dialogue = dialogue_box.instantiate()
var first_dialogue_trigger: bool = false
var first_dialogue: bool = true

var player_icons: Array = [
	"res://player_sprites/portrait_anemo.png",
	"res://player_sprites/portrait_hydro.png",
	"res://player_sprites/portrait_pyro.png",
	"res://player_sprites/portrait_dendro.png"
]

func _ready() -> void:
	$InteractSignal.hide()
	player = player_icons[Global.player_element]

func _process(_delta: float) -> void:
	if TransitionScreen.transitioning:
		return
	
	if first_dialogue_trigger:
		$Player.out_of_dialogue = false
		
		if Input.is_action_just_pressed("confirm"):
			match counter:
				0:
					dialogue.change_text("Um ar de familiaridade te atinge, você já esteve aqui antes?")
					counter += 1
				1:
					dialogue.change_text("Isso não importa. Você sente que precisa avançar...")
					counter += 1
				2:
					remove_child(dialogue)
					$Player.out_of_dialogue = true
					first_dialogue_trigger = false
					counter = 0

	if character_nearby and Input.is_action_just_pressed("confirm"):
		$InteractSignal.hide()
		add_child(dialogue)
		character_nearby = false
		character_never_entered = false
		$Player.out_of_dialogue = false
		started_dialogue = true
		
	if started_dialogue and Input.is_action_just_pressed("confirm"):
		match counter:
			0:
				dialogue.change_dialogue("...Essa criatura é familiar. Ainda deseja ficar no meu caminho?", "Você", player)
				counter += 1
			1:
				dialogue.change_dialogue("*rugido*","Dhrygon",unknown)
				counter += 1
			2:
				dialogue.change_dialogue("O dragão lhe ataca ferozmente ao te perceber dentro de seu território!", "???", unknown)
				counter += 1
			3:
				TransitionScreen.transitioning = true
				TransitionScreen.transition()
				await TransitionScreen.on_transition_finished
				call_deferred("change_scene")
				counter += 1

func change_scene():
	get_tree().change_scene_to_file("res://scenes/boss_fight.tscn")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and character_never_entered:
		$InteractSignal.show()
		character_nearby = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		$InteractSignal.hide()
		character_nearby = false

func _on_dialogue_trigger_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and first_dialogue:
		first_dialogue_trigger = true
		first_dialogue = false
		add_child(dialogue)
