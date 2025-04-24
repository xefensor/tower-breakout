extends CharacterBody2D
class_name Ball


@export var start_speed : float = 200

@export var _health : Health
@onready var _visible_on_screen_notifier_2D : VisibleOnScreenNotifier2D = NodeUtils.get_child_by_class(self, VisibleOnScreenNotifier2D) as VisibleOnScreenNotifier2D


func _ready() -> void:
	reset_physics_interpolation()
	
	_visible_on_screen_notifier_2D.screen_exited.connect(_on_death)
	_health.died.connect(queue_free)
	#velocity = Vector2.from_angle(rotation) * speed


func _physics_process(delta) -> void:
	velocity += get_gravity()
	
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		if collision_info.get_collider() is Paddle:
			return

		if collision_info.get_collider() is Enemy:
			(collision_info.get_collider() as Enemy).take_damage(1)

		_health.take_damage(1)
		var normal = collision_info.get_normal()
		velocity = velocity.bounce(normal) + collision_info.get_collider_velocity()
		move_and_collide(velocity * delta)


func _on_death() -> void:
	queue_free()


func take_damage(amount:int):
	_health.take_damage(amount)


func heal(amount:int):
	_health.heal(amount)
