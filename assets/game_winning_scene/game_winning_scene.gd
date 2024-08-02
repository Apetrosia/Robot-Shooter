extends Node
class_name GameWinningScene


@export_file("*.tscn") var game_scene: String
@export_file("*.tscn") var menu_scene: String


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func restart() -> void:
	get_tree().change_scene_to_file(game_scene)


func back_to_menu() -> void:
	get_tree().change_scene_to_file(menu_scene)
