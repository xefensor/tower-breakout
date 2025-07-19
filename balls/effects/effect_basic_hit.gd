class_name EffectBasicHit
extends Effect

var damage: int = 1

func do(effect_modifier: EffectModifier):
	if effect_modifier.targets:
		for target in effect_modifier.targets:
			if target.has_method("take_damage"):
				target.take_damage(damage)
	
	if next_effect:
		next_effect.do(effect_modifier)
