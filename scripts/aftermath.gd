extends CanvasLayer

func _ready() -> void:
	match Global.ending:
		1:
			$Text.text = "...Você corre grandes distâncias para fugir da besta feroz... Eventualmente, encontra uma saída da ilha e parte com um barco de madeira que algum viajante havia deixado ali."
		2:
			$Text.text = "...Você lutou até o seu último suspiro, porém, aquela criatura abominável foi capaz de te superar e lançou seu corpo sem vida em direção ao magma escaldante do vulcão."
		3:
			$Text.text = "...Esplêndido! Você saiu daquele local com uma vitória triunfante, indo direto ao próximo local de sua jornada... Que perigos lhe aguardam no futuro?"
	$Text.visible_characters = 0

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("confirm"):
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
