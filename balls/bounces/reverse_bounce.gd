class_name ReverseBounce
extends Bounce


func calculate_bounce(ball: Ball, collision_info: KinematicCollision2D) -> Vector2:
	var bounce: Vector2 = ball.velocity.rotated(PI)
	return bounce
