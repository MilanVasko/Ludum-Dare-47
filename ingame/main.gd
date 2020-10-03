extends Node2D

func _ready():
	var race_track: PackedScene = load("res://ingame/race_tracks/" + Settings.last_selected_map + "/" + Settings.last_selected_map + ".tscn")
	add_child(race_track.instance())
