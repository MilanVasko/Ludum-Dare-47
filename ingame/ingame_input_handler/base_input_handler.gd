extends Node2D

export(String) var boat_group
export(NodePath) var game_progress_path
onready var game_progress_node = get_node(game_progress_path)
var boats = [null, null, null, null]

func on_boat_registered(boat: Boat, index: int) -> void:
	boats[index] = boat

func _physics_process(delta) -> void:
	for i in range(boats.size()):
		if boats[i] != null && self.can_play(boats[i]):
			self.handle_boat(boats[i], i, delta)

func handle_boat(_boat: Boat, _index: int, _delta: float) -> void:
	assert(false, "Abstract class")

func can_play(boat: Boat) -> bool:
	return game_progress_node.elapsed_time >= 0.0 && \
		!game_progress_node.get_boat_progress(boat).has_finished()
