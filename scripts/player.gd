extends CharacterBody2D

const TAP_FORCE = 50.0
const GRAVITY_DIVIDER = 10
var gameOver = false
var firstTap = false

@onready var animation = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not gameOver:
		velocity += get_gravity()/GRAVITY_DIVIDER * delta
		move_and_slide()
	
func _on_game_over() -> void:
	gameOver = true
	animation.pause()
	
func _tap() -> void:
	velocity.y -= TAP_FORCE

func _input(event: InputEvent) -> void:
	if (event is InputEventScreenTouch and event.pressed) or (event is InputEventMouseButton and event.pressed) or Input.is_action_just_pressed("tap"):
		_tap()
