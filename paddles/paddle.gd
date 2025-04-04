extends AnimatableBody2D
class_name Paddle

@export var speed : float = 5
	
	
func _physics_process(delta: float) -> void:
	var _direction = Input.get_axis("paddle_left", "paddle_right")
	var _velocity = Vector2(_direction * speed, 0)
	move_and_collide(_velocity * delta)
	
	#var collision_info = move_and_collide(velocity * delta)
	#if collision_info:
	#	var normal = collision_info.get_normal()
	#	velocity = velocity.bounce(normal)
