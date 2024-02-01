extends Area3D
var opened
@export var locked = false
#rotates back and with cooldown forward
func use():
	if locked:
		return
	$AnimationPlayer.play("open")
	#if opened:
		#return
	#opened = true
	#await get_tree().create_timer(2).timeout
	#opened = false
func _process(_delta):
	#if opened:
		#$StaticBody3D.rotation.y = lerp($StaticBody3D.rotation.y,-90.0,delta * 10)
		#$StaticBody3D2.rotation.y = lerp($StaticBody3D2.rotation.y,90.0,delta * 10)
	#else:
		#$StaticBody3D.rotation.y = lerp($StaticBody3D.rotation.y,0.0,delta * 10)
		#$StaticBody3D2.rotation.y = lerp($StaticBody3D2.rotation.y,0.0,delta * 10)
	pass
