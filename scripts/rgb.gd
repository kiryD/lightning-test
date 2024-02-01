extends Node3D

@export var color := Color(1,1,1)
@export var energy = 1.0
func _ready():
	$RigidBody3D/SpotLight3D.light_color = color
	$RigidBody3D/SpotLight3D.light_energy = energy
