extends CharacterBody3D


signal died

const SPEED = 3.0
const JUMP_VELOCITY = 4.5

@export var player: Player
@export var max_hp: float


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var _shtoto := 1

@onready var hp: float = max_hp


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	get_node_or_null(^"HealthComponent")
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := global_position.direction_to(player.global_position)
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	var tar_angle = atan2(direction.x, direction.z)
	global_rotation.y = rotate_toward(global_rotation.y, tar_angle, 0.1) 
	move_and_slide()

func take_damage(value: float, source):
	hp-=value
	if hp <= 0:
		died.emit()
		queue_free()
