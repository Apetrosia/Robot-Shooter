extends CharacterBody3D
class_name Bullet

const SPEED = 25.0
var damage: float
var ttl: float = 5

var shooter: CharacterBody3D:
	get: 
		return shooter
	set(value):
		if shooter:
			remove_collision_exception_with(shooter)
		add_collision_exception_with(value)
		shooter = value

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(basis.z*delta*SPEED)
	if collision:
		for i in range(collision.get_collision_count()):
			var collider = collision.get_collider(i)
			HealthComponent.try_take_damage(collider, damage, self)
		queue_free()
	ttl-=delta
	if ttl<0:
		queue_free()
