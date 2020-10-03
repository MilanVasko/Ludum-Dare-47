extends Control

onready var current_time_node = $Time
onready var countdown = $Countdown

func on_elapsed_time_changed(new_elapsed_time: float):
	var is_countdown = new_elapsed_time < 0.0
	countdown.visible = is_countdown
	current_time_node.visible = !is_countdown

	if is_countdown:
		var time_until_start = -new_elapsed_time
		var whole_seconds = int(time_until_start)

		if whole_seconds == 0:
			countdown.rect_scale = Vector2.ONE
			countdown.text = "Go!"
		else:
			countdown.rect_scale = Vector2.ONE * (time_until_start - whole_seconds)
			countdown.text = str(whole_seconds)
	else:
		current_time_node.text = format_time(new_elapsed_time)

func format_time(time: float) -> String:
	var seconds = int(time)
	var minutes = seconds / 60
	return "Time: " + str_padding(minutes) + ":" + str_padding(stepify((time - seconds) + (seconds % 60), 0.01))

func str_padding(number) -> String:
	if number < 10:
		return "0" + str(number)
	return str(number)
