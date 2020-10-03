extends "res://ingame_input_handler/base_input_handler.gd"

func handle_boat(boat: Boat, _delta: float) -> void:
	if Input.is_action_just_pressed("right"):
		boat.swing_right_paddle()
	elif Input.is_action_just_pressed("left"):
		boat.swing_left_paddle()
