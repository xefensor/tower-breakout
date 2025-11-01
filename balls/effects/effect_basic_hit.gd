class_name EffectBasicHit
extends Effect


var damage: int = 1


func apply(effect_modifier: EffectModifier) -> void:
	if not effect_modifier.targets:
		return
		
	for target in effect_modifier.targets:
		if target.has_method("take_damage"):
			target.take_damage(damage)
