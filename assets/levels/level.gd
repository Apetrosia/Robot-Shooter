extends Node3D
class_name Level

signal finished()

func _on_level_finished():
	finished.emit()
