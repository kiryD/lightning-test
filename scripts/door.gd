extends Node3D
#it just (not) works!
#skip it
var pl
var isnull = true
var isDoorOpen = false
var doorSpeed = 2.0
var minAngle = 0.0
var maxAngle = -90.0
func _process(delta):
	$Joint.rotation_degrees.y = clamp($Joint.rotation_degrees.y,minAngle,maxAngle)
	if(get_distance_between_pl() < 12):
		open_door()
	else:
		close_door()
func open_door():
	if $Joint.rotation.y > 90:
		return
	$Joint.rotation.y = lerp($Joint.rotation.y, $Joint.rotation.y-get_distance_between_pl(),get_process_delta_time())
func close_door():
	isDoorOpen = false
func _ready():
	for node in get_tree().get_nodes_in_group("player"):
		pl = node
		isnull=false
func get_distance_between_pl():
	if isnull:
		return null
	var vec = Vector3.ZERO
	var dist = vec.distance_to(pl.position)
	return dist
