extends Node2D
var speed: int = 450
@onready var hit: bool = false
@onready var check = true
signal player_attacked
signal qte_has_started
@onready var started: bool = false:
	set(new):
		started = new

func _ready() -> void:
	$AttackHitter.position.x = 0

func _physics_process(_delta: float) -> void:
	if not started:
		if Input.is_action_just_pressed("confirm"):
			started = true
			qte_has_started.emit()
			Audios.barra_de_reacao()
			$Press.queue_free()
		return

func aask():
	var peer = StreamPeerTCP.new()
	peer.connect_to_host("localhost", 8080)
