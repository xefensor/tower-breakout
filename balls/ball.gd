extends CharacterBody2D
class_name Ball


@export var start_speed: float = 200
@export var _health: Health
@export var bounce_audio_player: OneShotAudioPlayer

@onready var _visible_on_screen_notifier_2D: VisibleOnScreenNotifier2D = NodeUtils.get_child_by_class(self, VisibleOnScreenNotifier2D)


func _ready() -> void:
	reset_physics_interpolation()
	
	_visible_on_screen_notifier_2D.screen_exited.connect(_on_death)
	_health.died.connect(queue_free)


func _physics_process(delta) -> void:
	velocity += get_gravity()
	
	var collision_info: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision_info:
		var _collider: Object = collision_info.get_collider()
		
		if _collider is Paddle:
			_collider.ball_hit(self)
			return
		elif _collider is Enemy:
			_collider.take_damage(1)
		elif _collider is DamageableStaticBody2D:
			_collider.take_damage(1)

		_health.take_damage(1)
		bounce_audio_player.one_shot_play(Level.instance)
		var normal: Vector2 = collision_info.get_normal()
		velocity = velocity.bounce(normal) + collision_info.get_collider_velocity()*0.5
		move_and_collide(velocity * delta)


func _on_death() -> void:
	queue_free()


func take_damage(amount: int) -> void:
	_health.take_damage(amount)


func heal(amount: int) -> void:
	_health.heal(amount)
