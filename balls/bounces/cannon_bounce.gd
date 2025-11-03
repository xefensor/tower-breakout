class_name CannonBounce
extends Bounce


func calculate_bounce(ball: Ball, collision_info: KinematicCollision2D,
 _hitted_enemy: bool) -> Vector2:
	var normal: Vector2 = collision_info.get_normal()
	var bounce: Vector2 = ball.velocity.bounce(normal)
	if collision_info.get_collider().is_queued_for_deletion():
		bounce = ball.velocity
	return bounce
