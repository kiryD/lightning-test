extends Area3D
@export var Scene: String
@export var FadeIn: bool = true
func _on_body_entered(body):
	if body.is_in_group("player"):
		if FadeIn:
			body.fadein()
			await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_file(Scene)
