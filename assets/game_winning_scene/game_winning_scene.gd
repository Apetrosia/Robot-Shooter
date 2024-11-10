extends Node
class_name GameWinningScene



func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func restart() -> void:
	get_tree().change_scene_to_packed(Scenes.game)


func back_to_menu() -> void:
	get_tree().change_scene_to_packed(Scenes.menu)
