extends Node3D
class_name Gun

@onready var animation_tree: AnimationTree = $AnimationTree


var reloading: int:
	get:
		# print_debug("CHECK RELOADING ", reloading)
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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_tree.active = true
	# animation_tree.animation_started.connect(func(anim):
		# print_debug("ANIMATION STARTED: ", anim))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
