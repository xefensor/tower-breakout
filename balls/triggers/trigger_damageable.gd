class_name TriggerDamageable
extends Trigger


func _init() -> void:
	effects.append(EffectBasicHit.new())
	


func trigger(collision_info: KinematicCollision2D):
	for i in effects:
		i.play(collision_info.get_collider())
		
	bounce.bounce(collision_info)
