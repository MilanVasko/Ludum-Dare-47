extends Node2D

var rounds_needed = 1
var boat_progresses = {}

var elapsed_time = -5.0

func _ready():
	get_tree().call_group("elapsed_time_listener", "on_elapsed_time_changed", elapsed_time)

func _process(delta):
	elapsed_time += delta
	get_tree().call_group("elapsed_time_listener", "on_elapsed_time_changed", elapsed_time)

func on_boat_registered(boat: Node) -> void:
	var node_key = self.get_node_key(boat)
	print("Registering boat " + node_key + ", rounds needed: " + str(rounds_needed))
	assert(!boat_progresses.has(node_key))
	boat_progresses[node_key] = BoatProgress.new(rounds_needed)

func on_boat_checkpoint_entered(boat: Node, checkpoint_index: int, checkpoint_count: int) -> void:
	var node_key = self.get_node_key(boat)
	assert(boat_progresses.has(node_key))
	var boat_progress: BoatProgress = boat_progresses[node_key]

	match boat_progress.progress_to_checkpoint(checkpoint_index, checkpoint_count):
		BoatProgress.CheckpointProgress.NEW_CHECKPOINT:
			print("on_new_checkpoint")
		BoatProgress.CheckpointProgress.NEW_ROUND:
			print("on_new_round")
		BoatProgress.CheckpointProgress.GOING_BACKWARDS:
			print("on_going_backwards")
		BoatProgress.CheckpointProgress.FINISHED:
			print("on_won")

func get_node_key(node: Node) -> String:
	return str(node.get_path())

func get_boat_progress(boat: Node) -> BoatProgress:
	var node_key = self.get_node_key(boat)
	assert(self.boat_progresses.has(node_key))
	return self.boat_progresses[node_key]

class BoatProgress:
	enum CheckpointProgress {
		NEW_CHECKPOINT,
		NEW_ROUND,
		GOING_BACKWARDS,
		FINISHED
	}

	var rounds: int
	var rounds_needed: int
	var current_checkpoint_index: int

	func _init(rounds_needed_: int):
		self.rounds = 0
		self.rounds_needed = rounds_needed_
		self.current_checkpoint_index = -1

	func has_finished() -> bool:
		return self.rounds == self.rounds_needed

	func progress_to_checkpoint(checkpoint_index: int, checkpoint_count: int):
		if checkpoint_index == self.current_checkpoint_index + 1:
			if checkpoint_count == checkpoint_index + 1:
				self.rounds += 1
				self.current_checkpoint_index = 0
				if self.has_finished():
					return CheckpointProgress.FINISHED
				else:
					return CheckpointProgress.NEW_ROUND
			else:
				self.current_checkpoint_index = checkpoint_index

			return CheckpointProgress.NEW_CHECKPOINT
		return CheckpointProgress.GOING_BACKWARDS
