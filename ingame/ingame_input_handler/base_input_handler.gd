extends Node2D

export(String) var boat_group
export(NodePath) var game_progress_path
onready var game_progress_node = get_node(game_progress_path)
var boats = []

func on_boat_registered(boat: Boat, _index: int) -> void:
	boats.append(boat)

func _physics_process(delta) -> void:
	for boat in boats:
		if self.can_play(boat):
			self.handle_boat(boat, delta)

func handle_boat(_boat: Boat, _delta: float) -> void:
	assert(false, "Abstract class")

func can_play(boat: Boat) -> bool:
	return game_progress_node.elapsed_time >= 0.0 && \
		!game_progress_node.get_boat_progress(boat).has_finished()
