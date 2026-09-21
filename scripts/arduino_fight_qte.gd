extends Node2D
var speed: int = 450
@onready var hit: bool = false
@onready var check = true
signal player_attacked
signal qte_has_started
@onready var started: bool = false:
	set(new):
		started = new

# i got this by throwing random numbers at a wall
# turns the 0-28 the arduino returns into 0-7 the code expects
func magic_formula(x: float) -> float:
	var divisor = 21.0 if x < 21 else 7.0
	return max(0.0, 7.0 - 7.0 * abs(x - 21.0) / divisor)

func _physics_process(_delta: float) -> void:
	if not started:
		started = true
		qte_has_started.emit()
		Audios.barra_de_reacao()
		Global.tcp_client.put_u8(115)
		Global.polling_movement = false
	
	if Global.tcp_client && Global.tcp_client.get_available_bytes() <= 0:
		return
	
	var size = Global.tcp_client.get_u32()
	var result = Global.tcp_client.get_data(size)
	var data = result[1]
	
	print("data: ", data[0])
	
	if data[0] != 118:
		return
	
	print("wawa: ", data[1])
	Global.player_qte = magic_formula(data[1])
	
	Global.polling_movement = true
	player_attacked.emit()
	print("emitted!")
