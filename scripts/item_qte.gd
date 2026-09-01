extends Node2D
var speed: int = 800
var direction: int = 1
var times_bounced: float = 1
@onready var hit: bool = false
@onready var check = true
signal item_chose

func _ready() -> void:
	$Hitter.position.x = 0

func _physics_process(_delta: float) -> void:
	# print(Global.item_qte)
	
	if Input.is_action_just_pressed("confirm") and not hit:
		hit = true
	
	if not hit:
		$Hitter.velocity.x = speed * direction
		$Hitter.move_and_slide()
		
		if $Hitter.position.x > 640:
			direction = -1
			times_bounced += 1
		
		if $Hitter.position.x < 0:
			direction = 1
			times_bounced += 1
		
		if times_bounced > 3:
			times_bounced = 3
	
	elif check:
		item_chose.emit()
		check = false
	
	else:
		return

func _on_deffense_buff_area_body_entered(_body: Node2D) -> void:
	Global.item_qte = "def"
	Global.item_value = 1 + (0.2 * (3 / times_bounced))

func _on_attack_buff_area_body_entered(_body: Node2D) -> void:
	Global.item_qte = "atk"
	Global.item_value = 1 + (0.3 * (3 / times_bounced))

func _on_heal_area_body_entered(_body: Node2D) -> void:
	Global.item_qte = "heal"
	Global.item_value = 45 / times_bounced

func _on_miss_area_body_entered(_body: Node2D) -> void:
	Global.item_qte = "none"
