extends Control

@onready var game_over = $GameOver
@onready var game_start = $GetReady
@onready var timer = $Timer
@onready var score_label = $ScoreContainer/Score
@onready var score_name = $ScoreContainer/Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_over.hide()
	score_label.hide()
	score_name.hide()

func _on_game_over() -> void:
	game_start.hide()
	score_label.hide()
	score_name.hide()
	game_over.show()

func _on_timer_timeout() -> void:
	game_start.hide()
	score_label.show()
	score_name.show()
	
func _on_score_update(score) -> void:
	score_label.text = str(score)
