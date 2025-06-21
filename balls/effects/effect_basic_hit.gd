class_name EffectBasicHit
extends Effect


func play(object: Object, damage: int = 1):
	if object.has_method("take_damage"):
		object.take_damage(damage)
