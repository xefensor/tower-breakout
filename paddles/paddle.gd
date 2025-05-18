class_name Paddle
extends AnimatableBody2D


@export var _speed: float = 5
@export var health: Health
@export var ball_hit_audio_player: AudioStreamPlayer

@onready var default_health: int = health.current_health
@onready var _area_2d: Area2D = NodeUtils.get_child_by_class(self, Area2D)
@onready var collision_shape_2d: CollisionShape2D = NodeUtils.get_child_by_class(self, CollisionShape2D)


func _ready() -> void:
	_area_2d.body_entered.connect(_on_area_2d_body_entered)
	health.health_changed.connect(_on_health_changed)


func _physics_process(delta: float) -> void:
	var _direction: float = Input.get_axis("paddle_left", "paddle_right")
	var _offset: Vector2 = Vector2(_direction * _speed * delta, 0)
	
	move_and_collide(_offset)
	

func ball_hit(ball: Ball) -> void:
	ball.heal(1)
	ball_hit_audio_player.play()

	var relative_hit_pos: float = (ball.global_position.x - collision_shape_2d.global_position.x) / (collision_shape_2d.shape.size.x * collision_shape_2d.global_scale.x * 0.5)
	relative_hit_pos = clamp(relative_hit_pos, -1.0, 1.0)

	var angle: float = deg_to_rad(85 * relative_hit_pos)  # -85° až 85°
	ball.velocity = Vector2(sin(angle), -cos(angle)).normalized() * ball.velocity.length()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Enemy:
		health.take_damage(body.paddle_damage)
		body.die()
	
	
func _on_health_changed(new_health: int) -> void:
	scale.x = default_health / 100.0 * new_health
	
