extends Node
class_name HealthComponent

signal died

const NODE_NAME = ^"HealthComponent"

@export var max_hp := 10.0
@onready var hp := max_hp

static func get_component(node: Node) -> HealthComponent:
	return node.get_node(NODE_NAME) as HealthComponent
	
static func try_take_damage(target: Node, damage: float, source: Node3D) -> bool:
	var component := target.get_node_or_null(NODE_NAME) as HealthComponent
	if !component:
		return false
	component.take_damage(damage, source)
	return true

func take_damage(damage: float, source: CharacterBody3D) -> void:
	get_parent().queue_free()
