extends Panel

onready var name_input = $HBoxContainer/Name/Value

signal name_changed(index, new_name)

func get_player_name() -> String:
	return name_input.text

func set_player_name(player_name: String) -> void:
	name_input.text = player_name

func _on_name_changed(new_name: String) -> void:
	emit_signal("name_changed", get_index(), new_name)
