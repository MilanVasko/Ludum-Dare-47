extends Node2D

onready var rotator = $Rotator
var is_rotating = false
var rotation_multiplier = -1.0
const ROTATION_SPEED = PI * 5
const MAX_ROTATION = 0
const MIN_ROTATION = -PI * 3 / 4

func swing():
	is_rotating = true
	rotator.rotation = MAX_ROTATION
	rotation_multiplier = -1.0

func _process(delta):
	if !is_rotating:
		return
	rotator.rotation += ROTATION_SPEED * delta * rotation_multiplier
	if rotator.rotation < MIN_ROTATION:
		rotator.rotation = MIN_ROTATION
		rotation_multiplier = 1.0
	elif rotator.rotation > MAX_ROTATION:
		rotator.rotation = MAX_ROTATION
		is_rotating = false
