extends Node2D
signal item_chose
signal itemqte_has_started
@onready var started: bool = false

const ITEM_LIGHTS := {
	"heal": 7,
	"def": 15,
	"atk": 22,
}

# each item's lit range grows by 1 light per side every 3 bounces, capped at 3 per side
func resolve_item(light: int, bounces: int) -> String:
	var spread = mini(3, bounces / 3)
	for item_name in ITEM_LIGHTS:
		if abs(light - ITEM_LIGHTS[item_name]) <= spread:
			return item_name
	return "none"

# i gave up on this one
func heal_value_formula(bounces: int) -> float:
	if bounces == 1:
		return 40.0
	if bounces == 2:
		return 37.0
	return 58.0 * pow(bounces, -0.585)

func def_value_formula(bounces: int) -> float:
	return 0.5 * (3.0 / bounces)

func atk_value_formula(bounces: int) -> float:
	return 1.1 + (0.6 * (4.0 / bounces))

func _physics_process(delta: float) -> void:
	if not started:
		started = true
		itemqte_has_started.emit()
		Audios.barra_de_reacao()
		Global.tcp_client.put_u8(ord("I"))
		Global.polling_movement = false

	if Global.tcp_client.get_available_bytes() <= 0:
		return

	var size = Global.tcp_client.get_u32()
	var result = Global.tcp_client.get_data(size)
	var data = result[1]

	if data[0] != ord("i"):
		return

	var light_selected = data[1]
	var bounce_count = data[2]
	bounce_count = clamp(bounce_count, 1, 100)

	Global.item_qte = resolve_item(light_selected, bounce_count)
	match Global.item_qte:
		"heal":
			Global.item_value = heal_value_formula(bounce_count)
		"def":
			Global.item_value = def_value_formula(bounce_count)
		"atk":
			Global.item_value = atk_value_formula(bounce_count)

	print("wawawa: ", Global.item_value)
	Global.polling_movement = true
	item_chose.emit()
