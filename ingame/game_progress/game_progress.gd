extends Node2D

var rounds_needed = Settings.last_number_of_rounds
var boat_progresses = {}
var finished_boats = []

var elapsed_time = -3.0

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
			get_tree().call_group("checkpoint_progress_listener", "on_boat_checkpoint_reached", boat, boat_progress.current_checkpoint_index, checkpoint_count - 1, elapsed_time)
		BoatProgress.CheckpointProgress.NEW_ROUND:
			get_tree().call_group("checkpoint_progress_listener", "on_boat_checkpoint_reached", boat, boat_progress.current_checkpoint_index, checkpoint_count - 1, elapsed_time)
			get_tree().call_group("checkpoint_progress_listener", "on_boat_new_round_reached", boat, boat_progress.rounds, elapsed_time)
		BoatProgress.CheckpointProgress.GOING_BACKWARDS:
			get_tree().call_group("checkpoint_progress_listener", "on_boat_going_backwards", boat)
		BoatProgress.CheckpointProgress.FINISHED:
			get_tree().call_group("checkpoint_progress_listener", "on_boat_new_round_reached", boat, boat_progress.rounds, elapsed_time)
			finished_boats.append(FinishEntry.new(boat, elapsed_time))
			var place = finished_boats.size()
			var boat_count = boat_progresses.size()
			get_tree().call_group("checkpoint_progress_listener", "on_boat_finished", boat, elapsed_time, place, boat_count)

func get_node_key(node: Node) -> String:
	return str(node.get_path())

func get_boat_progress(boat: Node) -> BoatProgress:
	var node_key = self.get_node_key(boat)
	assert(self.boat_progresses.has(node_key))
	return self.boat_progresses[node_key]

class FinishEntry:
	var boat: Node
	var finish_time: float

	func _init(boat_: Node, finish_time_: float):
		self.boat = boat_
		self.finish_time = finish_time_

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
		self.current_checkpoint_index = -2

	func has_finished() -> bool:
		return self.rounds == self.rounds_needed

	func progress_to_checkpoint(checkpoint_index: int, checkpoint_count: int):
		if self.current_checkpoint_index == -2 && checkpoint_index == checkpoint_count - 1:
			self.current_checkpoint_index += 1
			return CheckpointProgress.NEW_CHECKPOINT

		if checkpoint_index == self.current_checkpoint_index + 1:
			if checkpoint_index + 1 == checkpoint_count:
				self.rounds += 1
				self.current_checkpoint_index = -1
				if self.has_finished():
					return CheckpointProgress.FINISHED
				else:
					return CheckpointProgress.NEW_ROUND
			else:
				self.current_checkpoint_index = checkpoint_index

			return CheckpointProgress.NEW_CHECKPOINT
		return CheckpointProgress.GOING_BACKWARDS
