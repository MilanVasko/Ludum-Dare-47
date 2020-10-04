extends Camera2D

export(NodePath) var viewport_container_path
onready var viewport_container_node = get_node(viewport_container_path)
var target: Boat = null

func get_viewport_index() -> int:
	return viewport_container_node.get_index()

func on_boat_registered(boat: Boat) -> void:
	if self.get_viewport_index() != boat.get_index():
		return
	self.target = boat

func _physics_process(_delta):
	if target == null:
		return
	self.global_position = target.global_position
