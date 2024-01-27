extends Area3D
#rotates back and with cooldown forward
func use():
	$StaticBody3D.rotation.y = -90 
	$StaticBody3D2.rotation.y = 90 
	await get_tree().create_timer(2).timeout
	$StaticBody3D.rotation.y = 0
	$StaticBody3D2.rotation.y = 0
