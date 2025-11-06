class_name EffectBasicHit
extends Effect


var damage: int = 1


func apply(effect_modifier: EffectModifier) -> EffectModifier:
	if not effect_modifier.targets:
		return effect_modifier
		
	for target in effect_modifier.targets:
		if target.has_method("take_damage"):
			target.take_damage(damage)

	return effect_modifier
