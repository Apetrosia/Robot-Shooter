extends Node


@export var max_hp := 10.0
@onready var hp := max_hp


func take_damage(damage: float, source: CharacterBody3D) -> void:
	get_parent().queue_free()
