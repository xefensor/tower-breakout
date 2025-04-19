extends AnimatableBody2D
class_name Paddle


@export var speed : float = 5
@onready var _area_2d : Area2D = NodeUtils.get_child_by_class(self, Area2D)


func _ready() -> void:
	_area_2d.body_entered.connect(_on_area_2d_body_entered)


func _physics_process(delta: float) -> void:
	var _direction = Input.get_axis("paddle_left", "paddle_right")
	var _velocity = Vector2(_direction * speed, 0)
	
	var _collision_info = move_and_collide(_velocity * delta)
			
			
func _on_ball_hit(ball: Ball, position: Vector2) -> void:
	ball.heal(1)
	
	var relative_hit_pos = (position.x - global_position.x) / ($CollisionShape2D.shape.extents.x * 2 / 2.0)
	relative_hit_pos = clamp(relative_hit_pos, -1.0, 1.0)

	var angle = deg_to_rad(85 * relative_hit_pos)  # -85° až 85°
	ball.velocity = Vector2(sin(angle), -cos(angle)).normalized() * ball.velocity.length()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Ball:
		_on_ball_hit(body, body.global_position)
