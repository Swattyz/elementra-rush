extends TextureButton

var attack_element_textures: Array = [
	"res://object_sprites/button_attack_anemo.png",
	"res://object_sprites/button_attack_hydro.png",
	"res://object_sprites/button_attack_pyro.png",
	"res://object_sprites/button_attack_dendro.png"
]

var items_element_textures: Array = [
	"res://object_sprites/button_items_anemo.png",
	"res://object_sprites/button_items_hydro.png",
	"res://object_sprites/button_items_pyro.png",
	"res://object_sprites/button_items_dendro.png"
]

var run_away_element_textures: Array = [
	"res://object_sprites/button_run_away_anemo.png",
	"res://object_sprites/button_run_away_hydro.png",
	"res://object_sprites/button_run_away_pyro.png",
	"res://object_sprites/button_run_away_dendro.png"
]

var attack_element_texture: String
var items_element_texture: String
var run_away_element_texture: String

func _ready():
	grab_focus()
	attack_element_texture = attack_element_textures[Global.player_element]
	items_element_texture = items_element_textures[Global.player_element]
	run_away_element_texture = run_away_element_textures[Global.player_element]
	
	match name:
		"FightButton":
			texture_hover = load(attack_element_texture)
			texture_focused = load(attack_element_texture)
		"ItemButton":
			texture_hover = load(items_element_texture)
			texture_focused = load(items_element_texture)
		"RunButton":
			texture_hover = load(run_away_element_texture)
			texture_focused = load(run_away_element_texture)

func _on_mouse_entered() -> void:
	modulate = Color(1.2, 1.2, 1.2, 1.0)

func _on_focus_entered() -> void:
	modulate = Color(1.2, 1.2, 1.2, 1.0)

func _on_mouse_exited() -> void:
	modulate = Color(0.5, 0.5, 0.5, 1.0)

func _on_focus_exited() -> void:
	modulate = Color(0.5, 0.5, 0.5, 1.0)

func _on_button_down() -> void:
	modulate = Color(0.2, 0.2, 0.2, 1.0)

func _on_button_up() -> void:
	modulate = Color(1.2, 1.2, 1.2, 1.0)
