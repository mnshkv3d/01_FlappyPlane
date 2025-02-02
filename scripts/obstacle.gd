extends Area2D

const SPEED = 100.0

signal game_over
signal obstacle_pass

var isMoving = true
@onready var bypass_sound = $BypassSound

func _ready() -> void:
	_adjust_height_pos()

func _process(delta: float) -> void:
	if isMoving:
		position.x -= SPEED * delta
	if position.x < -900:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		emit_signal("game_over")

func _on_by_pass_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		emit_signal("obstacle_pass")
		bypass_sound.play()

func _on_game_over() -> void:
	isMoving = false
	
func _adjust_height_pos() -> void:
	position.y = randf_range(-60.0, 60.0)
	position.x = randf_range(0.0, 175.0)
