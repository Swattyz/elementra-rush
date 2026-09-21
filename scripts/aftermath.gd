extends CanvasLayer

var runaway_endings: Array = [
	"res://backgrounds/endings/runaway_ending_anemo.png",
	"res://backgrounds/endings/runaway_ending_hydro.png",
	"res://backgrounds/endings/runaway_ending_pyro.png",
	"res://backgrounds/endings/runaway_ending_dendro.png"
]

var narratives: Array = [
	"none",
	"...Você corre grandes distâncias para fugir da besta feroz... Eventualmente, encontra uma saída da ilha e parte com um barco de madeira que algum viajante havia deixado ali.",
	"...Você lutou até o seu último suspiro, porém aquela criatura abominável foi capaz de te superar e tirou sua vida... Uma ser desconhecido carregou seu corpo e o enterrou em um local mais calmo da ilha.",
	"...Esplêndido! Você saiu daquele local com uma vitória triunfante, indo direto ao próximo local de sua jornada... Que perigos lhe aguardam no futuro?"
]

func _ready() -> void:
	
	match Global.ending:
		1:
			$EndingImage.texture = load(runaway_endings[Global.player_element])
		2:
			$EndingImage.texture = load("res://backgrounds/endings/death_ending.png")
		3:
			$EndingImage.texture = load("res://backgrounds/endings/good_ending.png")
	
	$Text.text = narratives[Global.ending]
	$Text.visible_characters = 0

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("up"):
		Audios.click()
		
		if TransitionScreen.transitioning:
			return
		
		TransitionScreen.transitioning = true
		Global.ending = 0
		
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		call_deferred("change_scene")

func change_scene():
	get_tree().change_scene_to_file("res://scenes/ending.tscn")

func _on_timer_timeout() -> void:
	$Text.visible_characters += 1
	
	if $Text.visible_characters < $Text.text.length():
		Audios.enemy_dialogue()
