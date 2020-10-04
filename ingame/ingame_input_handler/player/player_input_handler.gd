extends "res://ingame/ingame_input_handler/base_input_handler.gd"

func handle_boat(boat: Boat, index: int, _delta: float) -> void:
	if Input.is_action_just_pressed("right_" + str(index)):
		boat.swing_right_paddle()
	if Input.is_action_just_pressed("left_" + str(index)):
		boat.swing_left_paddle()
