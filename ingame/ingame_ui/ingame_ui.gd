extends Control

onready var current_time_node = $Time/Value
onready var countdown = $Countdown
onready var finished = $Finished
onready var rounds_current_node = $Rounds/Value/Current
onready var rounds_max_node = $Rounds/Value/Max
onready var checkpoints_node = $Checkpoints
onready var checkpoints_current_node = $Checkpoints/Value/Current
onready var checkpoints_max_node = $Checkpoints/Value/Max
var viewport_index: int

func _ready():
	finished.visible = false
	rounds_current_node.text = "0"
	rounds_max_node.text = str(Settings.last_number_of_rounds)
	checkpoints_node.visible = false
	checkpoints_current_node.text = "0"
	checkpoints_max_node.text = "X"

func is_finished():
	return finished.visible

func on_boat_checkpoint_reached(boat: Node, checkpoint_index: int, checkpoint_count: int, elapsed_time: float) -> void:
	if !boat.is_in_group("player") || boat.get_index() != viewport_index:
		return
	checkpoints_node.visible = true
	checkpoints_current_node.text = str(checkpoint_index + 1)
	checkpoints_max_node.text = str(checkpoint_count)

func on_boat_new_round_reached(boat: Node, new_round: int, elapsed_time: float) -> void:
	if !boat.is_in_group("player") || boat.get_index() != viewport_index:
		return
	rounds_current_node.text = str(new_round)

func on_boat_going_backwards(boat: Node) -> void:
	print("on_boat_going_backwards")

func on_boat_finished(boat: Node, _elapsed_time: float, place: int, boat_count: int) -> void:
	if !boat.is_in_group("player") || boat.get_index() != viewport_index:
		return

	finished.visible = true
	if place == 1:
		finished.text = "You've won!"
	else:
		finished.text = "Place: " + str(place) + "/" + str(boat_count)

func on_elapsed_time_changed(new_elapsed_time: float) -> void:
	if self.is_finished():
		return

	var is_countdown = new_elapsed_time < 0.0
	countdown.visible = is_countdown

	if is_countdown:
		var time_until_start = -new_elapsed_time
		var whole_seconds = int(time_until_start)

		countdown.rect_scale = Vector2.ONE * (time_until_start - whole_seconds)
		countdown.text = str(whole_seconds + 1)
	else:
		if new_elapsed_time < 1.0:
			countdown.visible = true
			countdown.rect_scale = Vector2.ONE
			countdown.text = "Go!"
		current_time_node.text = format_time(new_elapsed_time)

func format_time(time: float) -> String:
	var seconds = int(time)
	var minutes = seconds / 60
	return str_padding(minutes) + ":" + str_padding(stepify((time - seconds) + (seconds % 60), 0.01))

func str_padding(number) -> String:
	if number < 10:
		return "0" + str(number)
	return str(number)
