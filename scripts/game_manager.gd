extends Node2D

var score = 0

@export var parallax_background: Node
@export var kill_zone: Node
@export var player: Node
@export var obstacle_spawner: Node
@export var ui: Node

@onready var restart_timer = $Timer

func _ready() -> void:
	if kill_zone:
		kill_zone.connect("game_over", _on_game_over, 0)
	else: print("No kill zone specified")
	if parallax_background:
		pass
	else: print("No parallax node specified")
	if player:
		pass
	else: print("No player node specified")
	if obstacle_spawner:
		pass
	else: print("No ObstacleSpawner node specified")
	if ui:
		pass
	else: print ("No UI node specified")

func _on_game_over() -> void:
	if GlobalScore.high_score < score:
		GlobalScore.high_score = score
	if parallax_background and parallax_background.has_method("_on_game_over"):
		parallax_background._on_game_over()
	if player and player.has_method("_on_game_over"):
		player._on_game_over()
	if obstacle_spawner and obstacle_spawner.has_method("_on_game_over"):
		print("spawner game over call")
		obstacle_spawner._on_game_over()
	print("--- Game Over ---")
	restart_timer.start()
	print("Restarting...")
	if ui and ui.has_method("_on_game_over"):
		print("UI")
		ui._on_game_over()
	print(GlobalScore.high_score)

func _on_obstacle_pass() -> void:
	score += 1
	if ui.has_method("_on_score_update"):
		ui._on_score_update(score)
	else: print("no score")
	
func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
