extends Control

var fight_qte_scenes: Array = [
	"res://scenes/fight_qte_old.tscn",
	"res://scenes/fight_qte.tscn"
]

var fight_qte_scene: PackedScene
var fight_qte

signal confirm_pressed

func _ready() -> void:
	fight_qte_scene = load(fight_qte_scenes[Global.gamemode])
	
	while true:
		await confirm_pressed
		Audios.click()
		fight_qte = fight_qte_scene.instantiate()
		add_child(fight_qte)
		await fight_qte.player_attacked
		await get_tree().create_timer(0.5).timeout
		await confirm_pressed
		Audios.click()
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		call_deferred("change_scene")
		await get_tree().process_frame

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("up"):
		confirm_pressed.emit()

func change_scene():
	get_tree().change_scene_to_file("res://scenes/element_choose.tscn")
