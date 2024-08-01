extends Node3D
class_name Axe

@onready var animation_tree: AnimationTree = $AnimationTree

var can_attack: bool = false

func fire_on():
	can_attack = true
	print("CAN ATTACK ", can_attack)
	
func fire_off():
	can_attack = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_tree.active = true

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
