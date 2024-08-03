extends Resource
class_name WeaponStats


@export var damage := 1.0
@export var bullets_per_shot: int = 1
@export var reloading_amount = 4
@export_range(0, 180, 0.1, "radians_as_degrees") var spread = PI/10
