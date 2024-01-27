extends CharacterBody3D

@export_category("Movement")
@export_subgroup("Velocity")
@export var SPEED = 1.7
@export var JUMP_VELOCITY = 2.3
@export_subgroup("Mouse")
@export var mouseSensibility = 1200
@export_subgroup("Head bob")
@export var head_start_pos = Vector3(0,1,0)
@export var HEAD_BOB := true
@export var HEAD_BOB_FREQUENCY := 0.2
@export var HEAD_BOB_AMPLITUDE := 0.01
@export_subgroup("Run parameters")
@export var stamina = 100
@export var max_stamina = 100
@export var mult_stamina = 25
@export var between_stand_or_run = 7
var mouse_relative_x = 0
var tick = 0
var mouse_relative_y = 0
var run
var step = true
var exhaust
@onready var newfov = $Camera3D.fov
@onready var last_speed = SPEED
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	print(stamina)
	fov_change(delta)
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	#if stamina_
	$CanvasLayer/ColorRect2.modulate = Color(1,1,1,1 - (stamina * 0.07))
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	#tick for head bob
	tick += 1
	#step and bob! sound
	if velocity && is_on_floor():
		head_bob_motion()
		if step:
			if run and !exhaust:
				footstep(0.25)
			else:
				footstep(0.45)
	reset_head_bob(delta)
	#run
	if run and stamina > 0 and !exhaust:
		SPEED = lerp(SPEED, 5.0, delta)
		newfov = 90.0
		HEAD_BOB_FREQUENCY = 0.35
		stamina -= delta * mult_stamina
		if stamina < 3:
			exhaust = true
			SPEED = lerp(SPEED, 1.0, delta*50)
	else:
		SPEED = lerp(SPEED, last_speed, delta)
		newfov = 75.0
		HEAD_BOB_FREQUENCY = 0.2
		if stamina < max_stamina:
			stamina += delta * (mult_stamina - between_stand_or_run)
		if exhaust and stamina > 40:
			exhaust = false
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "fwd", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
func _input(event):
	#mouse lock/unlock
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if event.is_action_pressed("key_l"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	#use items((monday left me) broken)
	if event.is_action_pressed("key_e") and $Head/RayCast3D.is_colliding():
		var ray = $Head/RayCast3D
		ray.get_collider().use()
	#run conditio
	if event.is_action_pressed("key_shift"):
		run = true
	if event.is_action_released("key_shift"):
		run = false
	#smooth rotation of player(it just works)
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x / mouseSensibility
		$Camera3D.rotation.y += (event.relative.x / mouseSensibility) * 1
		$Head.rotation.x -= event.relative.y/ mouseSensibility
		$Head.rotation.x = clamp($Head.rotation.x, deg_to_rad(-90), deg_to_rad(90))
		mouse_relative_x = clamp(event.relative.x,-50,50)
		mouse_relative_y = clamp(event.relative.y,-50,50)
func head_bob_motion():
	var pos = Vector3.ZERO
	pos.y += sin(tick * HEAD_BOB_FREQUENCY) * HEAD_BOB_AMPLITUDE
	pos.x += cos(tick * HEAD_BOB_FREQUENCY/2) * HEAD_BOB_AMPLITUDE * 2
	$Camera3D.position += pos
	
func reset_head_bob(delta):
	# Lerp back to the staring position
	if $Camera3D.position == head_start_pos:
		pass
	$Camera3D.position = lerp($Camera3D.position, head_start_pos, 2 * (1/HEAD_BOB_FREQUENCY) * delta)
func fov_change(delta):
	$Camera3D.fov = lerp($Camera3D.fov, newfov, delta)
func footstep(delay):
	step = false
	await get_tree().create_timer(delay).timeout
	$AudioStreamPlayer3D.playing=true
	step = true
