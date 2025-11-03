class_name BasicBounce
extends Bounce


func calculate_bounce(ball: Ball, collision_info: KinematicCollision2D,
 _hitted_enemy: bool) -> Vector2:
	var normal: Vector2 = collision_info.get_normal()
	var bounce: Vector2 = ball.velocity.bounce(normal)
	return bounce
