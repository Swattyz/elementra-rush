extends Node2D
var speed: int = 800
@onready var hit: bool = false
@onready var check = true
signal item_chose

func _ready() -> void:
	$Hitter.position.x = 0

func _physics_process(_delta: float) -> void:
	print(Global.item_qte)
	
	if Input.is_action_just_pressed("confirm") and not hit:
		hit = true
	
	if $Hitter.position.x < 640 and not hit:
		$Hitter.velocity.x = speed
		$Hitter.move_and_slide()
	
	elif check:
		item_chose.emit()
		check = false
	
	else:
		return

func _on_deffense_buff_area_body_entered(_body: Node2D) -> void:
	Global.item_qte = "def"

func _on_attack_buff_area_body_entered(_body: Node2D) -> void:
	Global.item_qte = "atk"

func _on_heal_area_body_entered(_body: Node2D) -> void:
	Global.item_qte = "heal"

func _on_miss_area_body_entered(_body: Node2D) -> void:
	Global.item_qte = "none"
