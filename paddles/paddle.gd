extends AnimatableBody2D
class_name Paddle


@export var _speed: float = 5
@export var health: Health
@export var ball_hit_audio_player: AudioStreamPlayer

@onready var _area_2d: Area2D = NodeUtils.get_child_by_class(self, Area2D)
@onready var default_health: int = health.current_health


func _ready() -> void:
	_area_2d.body_entered.connect(_on_area_2d_body_entered)
	health.health_changed.connect(_on_health_changed)


func _physics_process(delta: float) -> void:
	var _direction = Input.get_axis("paddle_left", "paddle_right")
	var _offset = Vector2(_direction * _speed * delta, 0)
	
	move_and_collide(_offset)
	

func _on_ball_hit(ball: Ball, position: Vector2) -> void:
	ball.heal(1)
	ball_hit_audio_player.play()
	
	var relative_hit_pos = (position.x - global_position.x) / ($CollisionShape2D.shape.extents.x * 2 / 2.0)
	relative_hit_pos = clamp(relative_hit_pos, -1.0, 1.0)

	var angle = deg_to_rad(85 * relative_hit_pos)  # -85° až 85°
	ball.velocity = Vector2(sin(angle), -cos(angle)).normalized() * ball.velocity.length()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Ball:
		_on_ball_hit(body, body.global_position)
	
	if body is Enemy:
		var _enemy = body as Enemy
		health.take_damage(_enemy.paddle_damage)
		_enemy.die()
	
	
func _on_health_changed(new_health: int) -> void:
	scale.x = default_health / 100.0 * new_health
	
