extends CharacterBody2D
class_name Ball


signal hitted_damageable(collision_info: KinematicCollision2D)

@export var weight: int = 10
@export var _health: Health
@export var bounce_audio_player: OneShotAudioPlayer

var triggers: Array[Trigger]

@onready var _visible_on_screen_notifier_2D: VisibleOnScreenNotifier2D = NodeUtils.get_child_by_class(self, VisibleOnScreenNotifier2D)


func _ready() -> void:
	reset_physics_interpolation()
	
	_visible_on_screen_notifier_2D.screen_exited.connect(_on_death)
	_health.died.connect(queue_free)

	triggers.append(TriggerDamageable.new())
	triggers[0].bounce.ball = self
	triggers[0].bounce.audio_player = $OneShotAudioPlayer
	hitted_damageable.connect(triggers[0].trigger)
	

func _physics_process(delta) -> void:
	velocity += get_gravity()
	
	var collision_info: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision_info:
		var _collider: Object = collision_info.get_collider()
		
		if _collider is Paddle:
			_collider.ball_hit(self)
			return
		elif _collider.has_method("take_damage"):
			hitted_damageable.emit(collision_info)

		_health.take_damage(1)
		move_and_collide(velocity * delta)


func _on_death() -> void:
	queue_free()


func take_damage(amount: int) -> void:
	_health.take_damage(amount)


func heal(amount: int) -> void:
	_health.heal(amount)
