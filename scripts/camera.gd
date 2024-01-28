extends Camera3D

func _process(delta):
	#lerps to $Head
	rotation = lerp(rotation, $"../Head".rotation, delta * 6)
