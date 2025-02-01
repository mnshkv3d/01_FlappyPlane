extends Control

@onready var game_over = $GameOver
@onready var game_start = $GetReady
@onready var score_label = $ScoreContainer/Score
@onready var score_name = $ScoreContainer/Label
@onready var highest_score = $GameOver/HighestScore
var is_game_over: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_over.hide()
	score_label.hide()
	score_name.hide()

func _on_game_over() -> void:
	highest_score.text = str(GlobalScore.high_score)
	game_start.hide()
	score_label.hide()
	score_name.hide()
	game_over.show()
	is_game_over = true

func _on_game_start() -> void:
	game_start.hide()
	if not is_game_over:
		score_label.show()
		score_name.show()
	
func _on_score_update(score) -> void:
	score_label.text = str(score)
