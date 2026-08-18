extends Node2D
var character_nearby: bool = false
var character_never_entered: bool = true
var dialogue_box: PackedScene = preload("res://scenes/dialogue_box.tscn")

func _ready() -> void:
	$InteractSignal.hide()
	print(Global.player_element)

func _process(_delta: float) -> void:
	if character_nearby and Input.is_action_just_pressed("confirm"):
		$InteractSignal.hide()
		var dialogue_scene = dialogue_box.instantiate()
		add_child(dialogue_scene)
		character_nearby = false
		character_never_entered = false
		$Player.out_of_dialogue = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and character_never_entered:
		$InteractSignal.show()
		character_nearby = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		$InteractSignal.hide()
		character_nearby = false
