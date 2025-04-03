extends CharacterBody2D
class_name Ball

@export var speed : float = 500

@onready var _health : Health = $Health as Health
@onready var _visible_on_screen_notifier_2D : VisibleOnScreenEnabler2D = $VisibleOnScreenNotifier2D as VisibleOnScreenEnabler2D


func _ready() -> void:
	_visible_on_screen_notifier_2D.screen_exited.connect(_on_death)
	_health.died.connect(_on_death)
	
	velocity = Vector2.from_angle(rotation) * speed


func _physics_process(delta) -> void:
	velocity += get_gravity()
	
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		
		#if collision_info.get_collider() is CharacterBody2D:
		#	_health.heal(1) 
		#else:
		#	_health.take_damage(1)
		
		#if collision_info.get_collider() is AnimatableBody2D:
		#	collision_info.get_collider().hit()
		
		var normal = collision_info.get_normal()
		velocity = velocity.bounce(normal)


func _on_death() -> void:
	queue_free()
