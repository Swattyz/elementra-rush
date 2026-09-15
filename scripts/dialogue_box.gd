extends CanvasLayer

@onready var mode: String = "enemy"

func _ready():
	$Text.visible_characters = 0

func change_dialogue(text,author,icon):
	$Text.text = str(text)
	$Author.text = str(author)
	$Icon.texture = load(icon)
	$Text.visible_characters = 0

func change_text(text):
	$Text.text = str(text)
	$Text.visible_characters = 0

func _on_timer_timeout() -> void:
	$Text.visible_characters += 1
	
	if self.name == "FightDialogue": return
	
	if $Text.visible_characters < $Text.text.length():
		if mode == "enemy":
			Audios.enemy_dialogue()
		else:
			Audios.player_dialogue()
