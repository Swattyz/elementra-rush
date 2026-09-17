extends Node2D
var speed: int = 450
@onready var hit: bool = false
@onready var check = true
signal player_attacked
signal qte_has_started
@onready var started: bool = false:
	set(new):
		started = new

func _physics_process(_delta: float) -> void:
	if not started:
		if Input.is_action_just_pressed("up"):
			started = true
			qte_has_started.emit()
			Audios.barra_de_reacao()
			Global.tcp_client.put_u8(115)
			Global.polling_movement = false
			$Press.queue_free()
		return
	
	if Global.tcp_client.get_available_bytes() <= 0:
		return
	
	var size = Global.tcp_client.get_u32()
	var result = Global.tcp_client.get_data(size)
	var data = result[1]
	
	if data[0] != 118:
		return
	
	print("wawa:", data[1])
