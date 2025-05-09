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
	
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		if collision_info.get_collider() is Paddle:
			return

		if collision_info.get_collider() is Enemy:
			(collision_info.get_collider() as Enemy).take_damage(1)

		_health.take_damage(1)
		bounce_audio_player.one_shot_play(Level.instance)
		var normal = collision_info.get_normal()
		velocity = velocity.bounce(normal) + collision_info.get_collider_velocity()*0.5
		move_and_collide(velocity * delta)


func _on_death() -> void:
	queue_free()


func take_damage(amount:int):
	_health.take_damage(amount)


func heal(amount:int):
	_health.heal(amount)
