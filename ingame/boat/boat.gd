extends RigidBody2D

class_name Boat

onready var left_paddle = $LeftPaddle
onready var right_paddle = $RightPaddle
var impulse = 1000

func _ready():
	get_tree().call_group("boat_register_listener", "on_boat_registered", self)

func swing_left_paddle():
	left_paddle.swing()
	self.apply_impulse_local(left_paddle.position, Vector2.UP * impulse)

func swing_right_paddle():
	right_paddle.swing()
	self.apply_impulse_local(right_paddle.position, Vector2.UP * impulse)

func apply_impulse_local(force: Vector2, pos: Vector2):
	var pos_local = self.transform.basis_xform(pos)
	var force_local = self.transform.basis_xform(force)
	self.apply_impulse(force_local, pos_local)
