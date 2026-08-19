extends CanvasLayer

func change_dialogue(text,author,icon):
	$Text.text = str(text)
	$Author.text = str(author)
	$Icon.texture = load(icon)

func change_text(text):
	$Text.text = str(text)
