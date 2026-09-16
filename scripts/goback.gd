extends Area2D

func change_scene():
	get_tree().change_scene_to_file("res://scenes/forest.tscn")

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		Global.coming_back = true
		TransitionScreen.transitioning = true
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		call_deferred("change_scene")
