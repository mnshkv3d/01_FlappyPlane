extends CharacterBody2D

const TAP_FORCE = 50.0
var gameOver = false

@onready var animation = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not gameOver:
		velocity += get_gravity()/10 * delta
		move_and_slide()
	if Input.is_action_just_pressed("tap"):
		velocity.y -= TAP_FORCE
	
func _on_game_over() -> void:
	gameOver = true
	animation.pause()
	
func _tap() -> void:
	velocity.y -= TAP_FORCE

func _input(event: InputEvent) -> void:
	if (event is InputEventScreenTouch and event.pressed) or (event is InputEventMouseButton and event.pressed):
		_tap()
