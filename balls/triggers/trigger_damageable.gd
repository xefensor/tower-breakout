class_name TriggerDamageable
extends Trigger


func _init() -> void:
	effects.append(EffectBasicHit.new())


func trigger(collision_info: KinematicCollision2D) -> void:
	var effect_mofifier: EffectModifier = EffectModifier.new()
	effect_mofifier.targets.append(collision_info.get_collider())
	for effect in effects:
		effect.apply(effect_mofifier)
