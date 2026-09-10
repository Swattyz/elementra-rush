extends Node2D

var cloud_scene: PackedScene = preload("res://scenes/cloud.tscn")
var counter: int = 0

var cloud_positions: Array = [
	Vector2(720, 180),
	Vector2(720, 145),
	Vector2(720, 110),
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
	var cloud_pos = cloud_positions[counter]
	var cloud_sprite = clouds.pick_random()
	
	cloud.position = cloud_pos
	cloud.texture = load(cloud_sprite)
	
	$Clouds.add_child(cloud)
	
	counter += 1
	
	if counter > 2: counter = 0
