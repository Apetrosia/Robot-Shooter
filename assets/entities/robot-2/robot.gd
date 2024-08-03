extends CharacterBody3D
class_name Robot

signal died

const SPEED = 3.0
const JUMP_VELOCITY = 4.5

@export var player: Player
@onready var health_component: HealthComponent = $HealthComponent
@onready var animation_player: AnimationPlayer = $"robot-2/AnimationPlayer"

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready() -> void:
	health_component.died.connect(die)

func _physics_process(delta: float) -> void:
	if health_component.hp <= 0:
		return
	if global_position.distance_to(player.global_position) < 5:
		animation_player.play("Axe_Fire")
	
	if not is_on_floor():
		velocity.y -= gravity * delta

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

func die():
	animation_player.play("Custom/Dead")

func on_dead_end():
	died.emit()
	queue_free()
