extends Area3D

@export var Text: String
@export var BottomText: String
@export var Reusable: bool = true
@export var Disabled: bool = false
var used
func _on_body_entered(body):
	if body.is_in_group("player"):
		if used and !Reusable or Disabled:
			return
		body.hint(Text, BottomText)
		
func _on_body_exited(body):
	if body.is_in_group("player"):
		body.dehint()
		used = true
