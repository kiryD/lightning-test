extends CharacterBody3D


const SPEED = 2.0
const JUMP_VELOCITY = 2.3
var mouseSensibility = 1200
var mouse_relative_x = 0
var mouse_relative_y = 0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

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
	#use(old)
	if event.is_action_pressed("key_e") and $Head/RayCast3D.is_colliding():
		var ray = $Head/RayCast3D
		if !ray.get_collider.has_method("use"):
			return
		ray.get_collider().use()
	#rotation of player(it just works)
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x / mouseSensibility
		$Camera3D.rotation.y += (event.relative.x / mouseSensibility) * 1
		$Head.rotation.x -= event.relative.y/ mouseSensibility
		$Head.rotation.x = clamp($Head.rotation.x, deg_to_rad(-90), deg_to_rad(90))
		mouse_relative_x = clamp(event.relative.x,-50,50)
		mouse_relative_y = clamp(event.relative.y,-50,50)
