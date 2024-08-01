extends Node3D
class_name Gun

@export var bullet_spawner: Node3D
@export var bullet_scene: PackedScene
@export var stats: WeaponStats

@export var shooter: CharacterBody3D
@export var bullet_amount = 4
@export var reloading_amount = 4


@onready var animation_tree: AnimationTree = $AnimationTree

var reloading: int:
	get:
		return reloading
	set(value):
		reloading = value

var can_fire: bool = false

func fire_on():
	can_fire = true

func fire_off():
	can_fire = false
	
func reload(ammo: int):
	reloading = ammo

func _on_fire():
	for i in range(stats.bullets_per_shot):
		_spawn_bullet()

func _spawn_bullet() -> Bullet:
	var bullet = bullet_scene.instantiate() as Bullet
	get_tree().root.add_child(bullet)
	bullet.shooter = shooter
	bullet.damage = stats.damage / stats.bullets_per_shot
	bullet.global_position = bullet_spawner.global_position
	bullet.global_rotation = bullet_spawner.global_rotation
	bullet.rotate_x(randf_range(-stats.spread, stats.spread))
	bullet.rotate_y(randf_range(-stats.spread, stats.spread))
	return bullet

func _on_reload():
	reloading -= 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(bullet_spawner != null, "NE UKAZALI BULLET_SPAWNER")
	
	animation_tree.active = true
	#animation_tree.animation_started.connect(func(anim):
		#print_debug("ANIMATION STARTED: ", anim))

