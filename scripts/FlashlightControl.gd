extends Control
#variables
enum STATE{ON, OFF, DISABLED}
var state = STATE.OFF
var stateb = false
var statea: String
func _input(event):
	#get key
	if statea == "Disabled":
		return
	if event.is_action_released("key_f"):
		stateb = !stateb
		if stateb:
			turnon()
		else:
			turnoff()

#Play animation, set state
func turnon():
	$AnimationPlayer.play("turnon")
	$"../../Head/SpotLight3D".visible = true
	state = STATE.ON
func turnoff():
	$AnimationPlayer.play("turnoff")
	$"../../Head/SpotLight3D".visible = false
	state = STATE.OFF

func _process(delta):
	#battery system
	match(state):
		STATE.ON:
			$ProgressBar.value-=delta*5
		STATE.OFF:
			$ProgressBar.value+=delta*5
	if $ProgressBar.value <= 0:
		turnoff()
	
func _ready():
	$AnimationPlayer.play("turnoff")
	$ProgressBar.set_deferred("size",Vector2(63, 252))
	#$ProgressBar.size = Vector2(63,252)
