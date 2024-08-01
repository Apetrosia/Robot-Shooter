extends Node
class_name MouseLookComponent


@export var character_body: CharacterBody3D
@export var camera_3d: Camera3D
@export var mouse_sensivity: float = 0.01
@export_range(0., 180., 0.5, "radians_as_degrees") var max_rotation_angle: float


func _unhandled_input(event: InputEvent) -> void:
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event is InputEventMouseMotion:
		var shift: Vector2 = event.relative * mouse_sensivity
		character_body.rotate_y(-shift.x)
		var cam_rot = camera_3d.rotation.x
		camera_3d.rotation.x = clampf(cam_rot - shift.y, -max_rotation_angle, max_rotation_angle)
