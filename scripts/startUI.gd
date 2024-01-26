extends Control
var despawn = false

#Wait for some time and then free text with fade out
func _process(delta):
	if $Label.modulate.a > 0 and despawn:
		$Label.modulate = Color(255,255,255,$Label.modulate.a - delta)
	if $Label.modulate.a < 0:
		free()

func _on_timer_timeout():
	despawn= true
