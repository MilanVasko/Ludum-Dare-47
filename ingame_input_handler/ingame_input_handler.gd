extends Node2D

export(NodePath) var game_progress_path
onready var game_progress_node = get_node(game_progress_path)
var player_node

func _ready():
	var players = get_tree().get_nodes_in_group("player")
	assert(players.size() == 1)
	player_node = players[0]

func _physics_process(_delta):
	if !can_play():
		return

	if Input.is_action_just_pressed("right"):
		player_node.swing_right_paddle()
	elif Input.is_action_just_pressed("left"):
		player_node.swing_left_paddle()

func can_play() -> bool:
	return game_progress_node.elapsed_time >= 0.0 && \
		!game_progress_node.get_boat_progress(player_node).has_finished()
