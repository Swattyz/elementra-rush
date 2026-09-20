extends CanvasLayer

var sceneries: Array = [
	"res://backgrounds/transition/transition_anemo.png",
	"res://backgrounds/transition/transition_hydro.png",
	"res://backgrounds/transition/transition_pyro.png",
	"res://backgrounds/transition/transition_dendro.png"
]

func _ready() -> void:
	$TextureRect.texture = load(sceneries[Global.player_element])
	match Global.player_element:
		0:
			$ColorRect2.color = Color.AQUAMARINE
		1:
			$ColorRect2.color = Color.DEEP_SKY_BLUE
		2:
			$ColorRect2.color = Color.LIGHT_CORAL
		3:
			$ColorRect2.color = Color.PALE_GREEN

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("up"):
		Audios.click()
		
		if TransitionScreen.transitioning:
			return
		
		TransitionScreen.transitioning = true
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		call_deferred("change_scene")

func change_scene():
	get_tree().change_scene_to_file("res://scenes/boss_fight_rework.tscn")
