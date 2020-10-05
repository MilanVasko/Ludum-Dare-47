extends RigidBody2D

class_name Boat

onready var left_paddle = $LeftPaddle
onready var right_paddle = $RightPaddle
onready var particles = $Particles
var impulse = 400

onready var max_particle_amount: int = particles.amount
const MIN_PARTICLE_SPEED = 50.0
const MAX_PARTICLE_SPEED = 500.0

func _ready():
	call_deferred("register")
	particles.scale = Vector2.ZERO

func register():
	get_tree().call_group("boat_register_listener", "on_boat_registered", self)

func _process(delta):
	var particles_material: ParticlesMaterial = particles.process_material
	var velocity_length = linear_velocity.length()
	var dir = linear_velocity
	if velocity_length > 1.0:
		dir /= velocity_length
	dir = -dir.rotated(-rotation)
	particles_material.direction = Vector3(dir.x, dir.y, 0.0)
	particles.scale = lerp(particles.scale, Vector2.ONE * clamp(velocity_length / MAX_PARTICLE_SPEED, 0.0, 1.0), delta)

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
