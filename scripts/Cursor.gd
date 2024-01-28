extends Control
var collide
func _on_player_collide():
	collide = true
	$ColorRect3.modulate.a = lerp($ColorRect3.modulate.a, 1.0, 0.014 * 10)
	$Label.modulate.a = lerp($Label.modulate.a, 1.0, 0.014*10)
func _process(delta):
	if not collide:
		$ColorRect3.modulate.a = lerp($ColorRect3.modulate.a, 0.0, 0.014 * 10)
		$Label.modulate.a = lerp($Label.modulate.a, 0.0, 0.014*10)
	collide = false
