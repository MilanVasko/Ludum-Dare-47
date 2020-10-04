extends Control

onready var current_time_node = $Time
onready var countdown = $Countdown
onready var finished = $Finished
var viewport_index: int

func _ready():
	finished.visible = false

func is_finished():
	return finished.visible

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
	current_time_node.visible = !is_countdown

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
	return "Time: " + str_padding(minutes) + ":" + str_padding(stepify((time - seconds) + (seconds % 60), 0.01))

func str_padding(number) -> String:
	if number < 10:
		return "0" + str(number)
	return str(number)
