extends Area3D

var player
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("player")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(player.position)
	position = lerp(position,player.position,delta*0.1)
