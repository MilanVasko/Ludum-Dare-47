extends RigidBody2D

onready var left_paddle = $LeftPaddle
onready var right_paddle = $RightPaddle
var impulse = 1000

func _ready():
	get_tree().call_group("game_progress", "on_boat_registered", self)

func _physics_process(_delta):
	var paddle = null
	if Input.is_action_just_pressed("right"):
		paddle = right_paddle
	elif Input.is_action_just_pressed("left"):
		paddle = left_paddle

	if paddle != null:
		paddle.swing()
		self.apply_impulse_local(paddle.position, Vector2.UP * impulse)

func apply_impulse_local(force: Vector2, pos: Vector2):
	var pos_local = self.transform.basis_xform(pos)
	var force_local = self.transform.basis_xform(force)
	self.apply_impulse(force_local, pos_local)
