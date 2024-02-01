extends Control
var collide

func _on_player_collide():
	collide = true
	$ColorRect3.modulate.a = lerp($ColorRect3.modulate.a, 1.0, 0.014 * 10)
	$ColorRect4.modulate.a = lerp($ColorRect4.modulate.a, 1.0, 0.014 * 10)
	$Label.modulate.a = lerp($Label.modulate.a, 1.0, 0.014*10)
func _process(_delta):
	if not collide:
		$ColorRect3.modulate.a = lerp($ColorRect3.modulate.a, 0.0, 0.014 * 10)
		$ColorRect4.modulate.a = lerp($ColorRect4.modulate.a, 0.0, 0.014 * 10)
		$Label.modulate.a = lerp($Label.modulate.a, 0.0, 0.014*10)
	
func _on_player_notcollide():
	collide = false
