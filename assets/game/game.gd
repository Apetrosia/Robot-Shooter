extends Node


@export var campaign: Campaign
@export var game_winning_scene: PackedScene
@onready var level_root: Node = $Level

var current_level = -1
var current_level_node: Level


func _ready() -> void:
	next_level()
	

func next_level():
	current_level+=1
	if current_level >= campaign.levels.size():
		print_debug(game_winning_scene)
		get_tree().change_scene_to_packed.bind(game_winning_scene).call_deferred()
		return
	if current_level_node:
		level_root.remove_child(current_level_node)
	var lvl = campaign.levels[current_level].instantiate() as Level
	level_root.add_child(lvl)
	lvl.finished.connect(next_level)
	current_level_node = lvl
