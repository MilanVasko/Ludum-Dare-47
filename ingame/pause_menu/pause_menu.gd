extends Control

var last_boat_finished = false

func _ready():
	self.set_paused(false)

func _process(_delta):
	if !last_boat_finished && Input.is_action_just_pressed("pause"):
		self.toggle_pause()

func _exit_tree():
	self.set_paused(false)

func toggle_pause():
	self.set_paused(!self.is_paused())

func is_paused() -> bool:
	return self.visible

func set_paused(paused: bool) -> void:
	get_tree().paused = paused
	self.visible = paused

func on_boat_finished(_boat: Node, _elapsed_time: float, place: int, boat_count: int) -> void:
	if place != boat_count:
		return
	last_boat_finished = true
	$Label.visible = false
	$HBoxContainer/Resume.visible = false
	set_paused(true)

func _on_resume_pressed():
	self.set_paused(false)

func _on_restart_pressed():
	var err = get_tree().reload_current_scene()
	assert(err == OK)

func _on_main_menu_pressed():
	var err = get_tree().change_scene("res://main_menu/main_menu.tscn")
	assert(err == OK)
