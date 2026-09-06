extends CanvasLayer

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
