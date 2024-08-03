extends Node3D
class_name Axe

@onready var animation_tree: AnimationTree = $AnimationTree
@export var damage: float = 1
@export var shooter: CharacterBody3D

var can_attack: bool = false
func _on_body_entered(body: Node3D) -> void:
	if body == shooter:
		return
	HealthComponent.try_take_damage(body, damage, self)

func fire_on():
	can_attack = true
	
func fire_off():
	can_attack = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_tree.active = true
