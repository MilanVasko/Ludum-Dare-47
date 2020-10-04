extends Panel

onready var name_input = $HBoxContainer/Name/Value

func _ready():
	name_input.text = Settings.player_names[self.get_index()]
	var left_input_events = InputMap.get_action_list("left_" + str(self.get_index()))
	assert(left_input_events.size() <= 1)
	if !left_input_events.empty():
		$HBoxContainer/Controls/UseLeftPaddle/Value.text = left_input_events[0].as_text()
	var right_input_events = InputMap.get_action_list("right_" + str(self.get_index()))
	if !right_input_events.empty():
		$HBoxContainer/Controls/UseRightPaddle/Value.text = right_input_events[0].as_text()

func _on_name_changed(new_name: String) -> void:
	Settings.player_names[self.get_index()] = new_name
	get_tree().call_group("player_name_listener", "on_player_name_changed", self.get_index(), new_name)
