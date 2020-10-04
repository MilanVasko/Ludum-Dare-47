extends Camera2D

export(int) var viewport_index
var target: Boat = null

func on_boat_registered(boat: Boat) -> void:
	if self.viewport_index != boat.get_index():
		return
	self.target = boat

func _physics_process(_delta):
	if target == null:
		return
	self.global_position = target.global_position
