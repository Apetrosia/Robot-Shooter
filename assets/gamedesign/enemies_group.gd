extends Node3D

signal all_killed

var robots = 0


func _ready() -> void:
	for child in get_children():
		robots+=1
		child.died.connect(func():
			robots-=1
			if robots == 0:
				all_killed.emit())

