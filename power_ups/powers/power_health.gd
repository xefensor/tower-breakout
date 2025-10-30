class_name PowerHealth
extends Power


@export var health: int = 1


func apply_effect() -> void:
	if type == Type.POWER_UP:
		paddle.health.heal(health)
	else:
		paddle.health.take_damage(health)
