class_name SniperBounce
extends Bounce


func calculate_bounce(ball: Ball, collision_info: KinematicCollision2D) -> Vector2:
	var normal: Vector2 = collision_info.get_normal()
	var bounce: Vector2 = ball.velocity.bounce(normal)
	
	if collision_info.get_collider().has_method("take_damage"):
		return bounce
	
	var enemies := ball.get_tree().get_nodes_in_group("enemies")
	
	if not enemies:
		return bounce
		
	var nearest_node: Node2D = null
	var nearest_distance: float = INF

	for node in enemies:
		var dist: float = ball.global_position.distance_to(node.global_position)
		if dist < nearest_distance:
			nearest_distance = dist
			nearest_node = node

	bounce = (nearest_node.global_position - ball.global_position).normalized() * ball.velocity.length()
	return bounce
