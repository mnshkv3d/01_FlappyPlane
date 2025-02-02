extends Node2D

var score = 0

@export var parallax_background: Node
@export var kill_zone: Node
@export var player: Node
@export var obstacle_spawner: Node
@export var ui: Node

@onready var restart_timer = $Timer
@onready var music = $Music
@onready var hit_sound = $HitSound

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

func _on_game_start() -> void:
	if ui and ui.has_method("_on_game_start"):
		ui._on_game_start()
	if obstacle_spawner and obstacle_spawner.has_method("_start_spawn"):
		obstacle_spawner._start_spawn()
	#print("game started")
	music.play()
	for i in range(-50.0, -11.45, 3.0):
		music.volume_db = i
		await get_tree().create_timer(0.1).timeout
		#print(i)
	
func _on_game_over() -> void:
	if GlobalScore.high_score < score:
		GlobalScore.high_score = score
	if parallax_background and parallax_background.has_method("_on_game_over"):
		parallax_background._on_game_over()
	if player and player.has_method("_on_game_over"):
		player._on_game_over()
	if obstacle_spawner and obstacle_spawner.has_method("_on_game_over"):
		#print("spawner game over call")
		obstacle_spawner._on_game_over()
	#print("--- Game Over ---")
	hit_sound.play()
	music.stop()
	restart_timer.start()
	#print("Restarting...")
	if ui and ui.has_method("_on_game_over"):
		#print("UI")
		ui._on_game_over()
	#print(GlobalScore.high_score)

func _on_obstacle_pass() -> void:
	score += 1
	if ui.has_method("_on_score_update"):
		ui._on_score_update(score)
	else: print("no score")
	
func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
