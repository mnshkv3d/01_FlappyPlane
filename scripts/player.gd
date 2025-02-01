extends CharacterBody2D

const TAP_FORCE = 50.0
const GRAVITY_DIVIDER = 10
const MAX_ROTATION = 25
const ROTATION_SPEED = 10

var gameOver = false
var firstTap = false

@onready var animation = $AnimatedSprite2D
@onready var timer = $Timer
@onready var game_manager = $/root/Main/GameManager

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not gameOver and timer.is_stopped():
		velocity += get_gravity()/GRAVITY_DIVIDER * delta
		move_and_slide()
		update_rotation(delta)
	elif not gameOver: 
		move_and_slide()
		
func update_rotation(delta: float) -> void:
	var target_angle = 0.0
	
	if velocity.y > 0:
		target_angle = deg_to_rad(MAX_ROTATION)
	elif velocity.y < 0:
		target_angle = deg_to_rad(-MAX_ROTATION)
	
	animation.rotation = lerp_angle(animation.rotation, target_angle, ROTATION_SPEED * delta)

func _on_game_over() -> void:
	gameOver = true
	animation.pause()
	
func _tap() -> void:
	velocity.y -= TAP_FORCE
	update_rotation(0.01)
	if not timer.is_stopped():
		timer.stop()
		if game_manager and game_manager.has_method("_on_game_start"):
			game_manager._on_game_start()

func _input(event: InputEvent) -> void:
	if (event is InputEventScreenTouch and event.pressed) or (event is InputEventMouseButton and event.pressed) or Input.is_action_just_pressed("tap"):
		_tap()
