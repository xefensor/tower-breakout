@abstract
class_name Effect
extends Resource


@export var fire_rate_mod: float = 1
@export var launch_speed_mod: int = 1
@export var health_mod: int = 1


@abstract
func apply(effect_modifiers: Dictionary) -> Dictionary
