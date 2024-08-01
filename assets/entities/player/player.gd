extends CharacterBody3D
class_name Player

const SPEED = 5.0
const ACCELERATION = 1.75
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var mouse_sensivity: float = 0.01
@export_range(0., 180., 0.5, "radians_as_degrees") var max_rotation_angle: float
@export var weapons: Array[Node3D]
var active_weapon_id: int = 0

@onready var camera: Camera3D = %Camera3D


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	weapons[active_weapon_id].process_mode = Node.PROCESS_MODE_INHERIT
	weapons[active_weapon_id].show()
	for i in range(1, weapons.size()):
		weapons[i].process_mode = Node.PROCESS_MODE_DISABLED
		weapons[i].hide()


func _unhandled_input(event: InputEvent) -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event is InputEventMouseMotion:
		var shift: Vector2 = event.relative * mouse_sensivity
		rotate_y(-shift.x)
		var cam_rot = camera.rotation.x
		camera.rotation.x = clampf(cam_rot - shift.y, -max_rotation_angle, max_rotation_angle)
	elif event.is_action_pressed("fire"):
		weapons[active_weapon_id].fire_on()
	elif event.is_action_released("fire"):
		weapons[active_weapon_id].fire_off()
	elif event.is_action_pressed("reload"):
		# TODO проверка, не топор ли
		weapons[active_weapon_id].reload(weapons[active_weapon_id].reloading_amount)
		
	if Input.is_action_just_pressed("shotgun"):
		weapons[active_weapon_id].process_mode = Node.PROCESS_MODE_DISABLED
		weapons[active_weapon_id].hide();
		active_weapon_id = 0
		weapons[active_weapon_id].process_mode = Node.PROCESS_MODE_INHERIT
		weapons[active_weapon_id].show();
	if Input.is_action_just_pressed("pistol"):
		weapons[active_weapon_id].process_mode = Node.PROCESS_MODE_DISABLED
		weapons[active_weapon_id].hide();
		active_weapon_id = 1
		weapons[active_weapon_id].process_mode = Node.PROCESS_MODE_INHERIT
		weapons[active_weapon_id].show();
	if Input.is_action_just_pressed("axe"):
		weapons[active_weapon_id].process_mode = Node.PROCESS_MODE_DISABLED
		weapons[active_weapon_id].hide();
		active_weapon_id = 2
		weapons[active_weapon_id].process_mode = Node.PROCESS_MODE_INHERIT
		weapons[active_weapon_id].show();

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	if Input.is_action_pressed("run"):
		velocity.x *= ACCELERATION
		velocity.z *= ACCELERATION

	move_and_slide()
