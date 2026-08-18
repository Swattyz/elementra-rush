extends CanvasLayer
var counter: int = 0
var unknown = preload("res://object_sprites/unknown_identity_icon.png")
var player: String

var player_icons: Array = [
	"res://player_sprites/portrait_anemo.png",
	"res://player_sprites/portrait_hydro.png",
	"res://player_sprites/portrait_pyro.png",
	"res://player_sprites/portrait_dendro.png"
]

func _ready():
	player = player_icons[Global.player_element]

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("confirm"):
		match counter:
			0:
				$Text.text = "Um ar de familiaridade te atinge, você já esteve aqui antes?"
				counter += 1
			1:
				$Text.text = "Isso não importa. Você sente que precisa avançar..."
				counter += 1
			2:
				$Text.text = "...Essa criatura é familiar. Ainda deseja ficar no meu caminho?"
				$Author.text = "Você"
				$Icon.texture = load(player)
				counter += 1
			3:
				$Text.text = "*rugido*"
				$Author.text = "Dhrygon"
				$Icon.texture = unknown
				counter += 1
			4:
				$Text.text = "O dragão lhe ataca ferozmente ao te perceber dentro de seu território!"
				$Author.text = "???"
				$Icon.texture = unknown
				counter += 1
			_:
				hide()
				TransitionScreen.transition()
				await TransitionScreen.on_transition_finished
				call_deferred("change_scene")

func change_scene():
	get_tree().change_scene_to_file("res://scenes/boss_fight.tscn")
