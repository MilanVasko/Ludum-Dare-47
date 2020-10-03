extends Camera2D

export(int) var index
var target: Boat = null

func on_boat_registered(boat: Boat, boat_index: int) -> void:
	if self.index != boat_index:
		return
	self.target = boat

func _physics_process(_delta):
	if target == null:
		return
	self.global_position = target.global_position
