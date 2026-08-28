extends Node2D
var speed: int = 600
@onready var hit: bool = false
@onready var check = true
signal player_attacked

func _ready() -> void:
	$AttackHitter.position.x = 0

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("confirm") and not hit:
		hit = true
	
	if $AttackHitter.position.x < 640 and not hit:
		$AttackHitter.velocity.x = speed
		$AttackHitter.move_and_slide()
	
	elif check:
		player_attacked.emit()
		check = false
	
	else:
		return

func _on_min_damage_area_body_entered(_body: Node2D) -> void:
	Global.player_damage = 1

func _on_lesser_damage_area_body_entered(_body: Node2D) -> void:
	Global.player_damage = 2

func _on_med_damage_area_body_entered(_body: Node2D) -> void:
	Global.player_damage = 3

func _on_good_damage_area_body_entered(_body: Node2D) -> void:
	Global.player_damage = 4

func _on_high_damage_area_body_entered(_body: Node2D) -> void:
	Global.player_damage = 5

func _on_higher_damage_area_body_entered(_body: Node2D) -> void:
	Global.player_damage = 6

func _on_max_damage_area_body_entered(_body: Node2D) -> void:
	Global.player_damage = 7

func _on_miss_damage_area_body_entered(_body: Node2D) -> void:
	Global.player_damage = 0
