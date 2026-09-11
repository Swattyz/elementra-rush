extends Node2D

var cloud_scene: PackedScene = preload("res://scenes/cloud.tscn")

var cloud_positions: Array = [
	Vector2(720, 170),
	Vector2(720, 145),
	Vector2(720, 120),
	Vector2(720, 135),
	Vector2(720, 160),
	Vector2(720, 180)
]

var clouds: Array = [
	"res://object_sprites/cloud_1.png",
	"res://object_sprites/cloud_2.png",
	"res://object_sprites/cloud_3.png"
]

func _on_trigger_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		$Player.out_of_dialogue = false
		modulate = Color(0.5, 0.5, 0.5, 1.0)
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		call_deferred("change_scene")

func change_scene():
	get_tree().change_scene_to_file("res://scenes/pre_fight.tscn")

func _on_timer_timeout() -> void:
	var cloud = cloud_scene.instantiate()
	var cloud_pos = cloud_positions.pick_random()
	var cloud_sprite = clouds.pick_random()
	
	cloud.position = cloud_pos
	cloud.texture = load(cloud_sprite)
	
	$Clouds.add_child(cloud)
