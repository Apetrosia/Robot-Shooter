extends Label3D

@export var entity: Node

func _process(delta: float) -> void:
	text = str(entity.hp)
