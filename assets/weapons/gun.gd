extends Node3D
class_name Gun

@onready var animation_tree: AnimationTree = $AnimationTree

@export var bullet_amount = 4
@export var reloading_amount = 4

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

func _on_reload():
	reloading-=1

func _ready() -> void:
	animation_tree.active = true
	# animation_tree.animation_started.connect(func(anim):
		# print_debug("ANIMATION STARTED: ", anim))
