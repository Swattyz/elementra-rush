extends Node

func _on_element_anemo_pressed() -> void:
	Global.player_element = 0

func _on_element_hydro_pressed() -> void:
	Global.player_element = 1

func _on_element_pyro_pressed() -> void:
	Global.player_element = 2

func _on_element_dendro_pressed() -> void:
	Global.player_element = 3
