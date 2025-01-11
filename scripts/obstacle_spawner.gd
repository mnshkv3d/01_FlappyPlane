extends Node2D

@export var obstacle_scene: PackedScene
@export var game_manager: Node
var spawn_timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer = Timer.new()
	spawn_timer.wait_time = 3.0
	spawn_timer.one_shot = false
	spawn_timer.connect("timeout", _spawn_obstacle, 0)
	add_child(spawn_timer)
	spawn_timer.start()

func _spawn_obstacle():
	var obstacle_instance = obstacle_scene.instantiate()
	add_child(obstacle_instance)
	if obstacle_instance.has_signal("game_over"):
		obstacle_instance.connect("game_over", Callable(game_manager, "_on_game_over"), 0)
	if obstacle_instance.has_signal("obstacle_pass"):
		obstacle_instance.connect("obstacle_pass", Callable(game_manager, "_on_obstacle_pass"), 0)

func _on_game_over() -> void:
	spawn_timer.stop()
	var nodes = get_tree().get_nodes_in_group("obstacle")
	for node in nodes:
		if node.has_method("_on_game_over"):
			node._on_game_over()
