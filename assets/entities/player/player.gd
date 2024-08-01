extends CharacterBody3D
class_name Player

const SPEED = 5.0
const ACCELERATION = 1.75
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var mouse_sensivity: float = 0.01
@export_range(0., 180., 0.5, "radians_as_degrees") var max_rotation_angle: float
@export var gun: Gun
@export var axe: Axe

@onready var camera: Camera3D = %Camera3D


func _ready() -> void:
	gun.process_mode = Node.PROCESS_MODE_INHERIT
	gun.show()
	axe.process_mode = Node.PROCESS_MODE_DISABLED
	axe.hide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("fire"):
		gun.fire_on()
		gun._on_fire()
		axe.attack_on()
	elif event.is_action_released("fire"):
		gun.fire_off()
		axe.attack_off()
	elif event.is_action_pressed("reload"):
		gun.reload(gun.reloading_amount)
		
	if Input.is_action_just_pressed("change"):
		if gun.process_mode == Node.PROCESS_MODE_DISABLED:
			gun.process_mode = Node.PROCESS_MODE_INHERIT
			gun.show()
		else:
			gun.process_mode = Node.PROCESS_MODE_DISABLED
			gun.hide()
		if axe.process_mode == Node.PROCESS_MODE_DISABLED:
			axe.process_mode = Node.PROCESS_MODE_INHERIT
			axe.show()
		else:
			axe.process_mode = Node.PROCESS_MODE_DISABLED
			axe.hide()

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
