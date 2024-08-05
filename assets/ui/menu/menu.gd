extends TextureRect


@export var game_scene: PackedScene
@onready var menu: HBoxContainer = $Menu
@onready var settings: Panel = $Settings


func _on_start_pressed() -> void:
	get_tree().change_scene_to_packed(game_scene)


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_settings_pressed() -> void:
	menu.visible = !menu.visible
	settings.visible = !settings.visible


func _on_ok_pressed() -> void:
	menu.visible = !menu.visible
	settings.visible = !settings.visible


func _on_cancel_pressed() -> void:
	menu.visible = !menu.visible
	settings.visible = !settings.visible
