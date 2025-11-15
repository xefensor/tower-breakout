class_name BasicHitEffect
extends Effect


@export var damage: int = 1


func apply(effect_modifiers: Dictionary) -> Dictionary:
	if not effect_modifiers.has("targets"):
		return effect_modifiers
	
	for target: Node in effect_modifiers["targets"]:
		if target.has_method("take_damage"):
			target.take_damage(damage)

	return effect_modifiers
