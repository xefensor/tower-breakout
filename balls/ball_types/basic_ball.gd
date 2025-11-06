class_name BasicBall
extends Ball


func _physics_process(delta: float) -> void:
	velocity += get_gravity()
	
	var collision_info: KinematicCollision2D = move_and_collide(velocity * delta)
	if not collision_info:
		return
		
	var collider: Object = collision_info.get_collider()
	
	if collider is Paddle:
		collider.ball_hit(self)
		return
		
	if collider.has_method("take_damage"):
		var effect_mofifier: EffectModifier = EffectModifier.new()
		effect_mofifier.targets.append(collision_info.get_collider())
		apply_effects(effect_mofifier)

	bounce_audio_player.one_shot_play(Level.instance)
	velocity = bounce.calculate_bounce(self, collision_info) + collision_info.get_collider_velocity() * 0.5

	_health.take_damage(1)
	move_and_collide(velocity * delta)
