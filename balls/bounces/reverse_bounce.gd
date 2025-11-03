class_name ReverseBounce
extends Bounce


func calculate_bounce(ball: Ball, _collision_info: KinematicCollision2D,
 _hitted_enemy: bool) -> Vector2:
	var bounce: Vector2 = ball.velocity.rotated(PI)
	return bounce
