extends Node

func _on_element_anemo_pressed() -> void:
	Global.player_element = "Anemo"

func _on_element_hydro_pressed() -> void:
	Global.player_element = "Hydro"

func _on_element_pyro_pressed() -> void:
	Global.player_element = "Pyro"

func _on_element_dendro_pressed() -> void:
	Global.player_element = "Dendro"
