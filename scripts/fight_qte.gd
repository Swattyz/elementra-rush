extends Node2D
var speed: int = 600
var current_damage: int = 0
var hit: bool = false
var check = true

func _ready() -> void:
	$AttackHitter.position.x = 1

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("confirm") and not hit:
		hit = true
	
	if $AttackHitter.position.x < 640 and not hit:
		$AttackHitter.velocity.x = speed
		$AttackHitter.move_and_slide()
	
	else:
		Global.player_damage = current_damage

func _on_min_damage_area_body_entered(_body: Node2D) -> void:
	current_damage = 1


func _on_lesser_damage_area_body_entered(_body: Node2D) -> void:
	current_damage = 2


func _on_med_damage_area_body_entered(_body: Node2D) -> void:
	current_damage = 3


func _on_good_damage_area_body_entered(_body: Node2D) -> void:
	current_damage = 4


func _on_high_damage_area_body_entered(_body: Node2D) -> void:
	current_damage = 5


func _on_higher_damage_area_body_entered(_body: Node2D) -> void:
	current_damage = 6


func _on_max_damage_area_body_entered(_body: Node2D) -> void:
	current_damage = 7
