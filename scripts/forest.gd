extends Node2D

func _on_trigger_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		$Player.out_of_dialogue = false
		modulate = Color(0.5, 0.5, 0.5, 1.0)
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		call_deferred("change_scene")

func change_scene():
	get_tree().change_scene_to_file("res://scenes/pre_fight.tscn")
