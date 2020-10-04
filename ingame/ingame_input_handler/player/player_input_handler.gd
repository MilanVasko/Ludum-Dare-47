extends "res://ingame/ingame_input_handler/base_input_handler.gd"


func _physics_process(delta) -> void:
	var player_names = Settings.player_names
	var boat_index = 0
	for i in range(player_names.size()):
		if player_names[i] == "":
			continue
		if boats[boat_index] != null && self.can_play(boats[boat_index]):
			self.handle_boat(boats[boat_index], i, delta)
		boat_index += 1

func handle_boat(boat: Boat, index: int, _delta: float) -> void:
	if Input.is_action_just_pressed("right_" + str(index)):
		boat.swing_right_paddle()
	if Input.is_action_just_pressed("left_" + str(index)):
		boat.swing_left_paddle()
