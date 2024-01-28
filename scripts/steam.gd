extends GPUParticles3D
#emit particles
func _ready():
	await get_tree().create_timer(5).timeout
	emmit()
func emmit():
	emitting = true
	await get_tree().create_timer(1).timeout
	emitting = false
	await get_tree().create_timer(5).timeout
	emmit()
