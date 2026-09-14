extends CanvasLayer

func _ready():
	$Text.visible_characters = 0

func change_dialogue(text,author,icon):
	$Text.text = str(text)
	$Author.text = str(author)
	$Icon.texture = load(icon)
	$Text.visible_characters = 0
	$AnimationPlayer.play("play")

func change_text(text):
	$Text.text = str(text)
	$AnimationPlayer.play("play")
