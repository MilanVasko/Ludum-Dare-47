extends Sprite

export(Texture) var texture1
export(Texture) var texture2
export(Color) var color_min
export(Color) var color_max
export(float) var scale_change_min = 0.5
export(float) var scale_change_max = 1.5

func _ready():
	if randi() % 2 == 0:
		self.texture = texture1
	else:
		self.texture = texture2
	self.scale *= rand_range(scale_change_min, scale_change_max)
	self.rotation = rand_range(0, PI)
	self.modulate = color_min.linear_interpolate(color_max, randf())
