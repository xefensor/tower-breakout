extends AnimatableBody2D
class_name Paddle


@export var speed : float = 5


func _physics_process(delta: float) -> void:
	var _direction = Input.get_axis("paddle_left", "paddle_right")
	var _velocity = Vector2(_direction * speed, 0)
	
	var collision_info = move_and_collide(_velocity * delta)
	if collision_info:
		var collider = collision_info.get_collider()
		if collider is Ball:
			var ball = collider
			_on_ball_hit(ball, collision_info.get_position())
			
			
func _on_ball_hit(ball: Ball, position: Vector2) -> void:
	ball.heal(1)
	
	var relative_hit_pos = (position.x - global_position.x) / ($CollisionShape2D.shape.extents.x * 2 / 2.0)
	relative_hit_pos = clamp(relative_hit_pos, -1.0, 1.0)

	var angle = deg_to_rad(85 * relative_hit_pos)  # -85° až 85°
	ball.velocity = Vector2(sin(angle), -cos(angle)).normalized() * ball.speed
