extends Node

@export var levels: Array[PackedScene]
@onready var level_root: Node = $Level

var current_level = -1
func _ready() -> void:
	next_level()
	
func next_level():
	current_level+=1
	for child in level_root.get_children():
		level_root.remove_child(child)
	var lvl = levels[current_level].instantiate() as Level
	level_root.add_child(lvl)
	lvl.finished.connect(next_level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
