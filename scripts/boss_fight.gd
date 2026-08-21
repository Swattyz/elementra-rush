extends Node2D
var fight_hud_scene: PackedScene = preload("res://scenes/fight_hud.tscn")
var fight_hud_instance = (fight_hud_scene).instantiate()

func _ready() -> void:
	add_child(fight_hud_instance)

func _process(_delta: float) -> void:
	pass
