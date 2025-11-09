@abstract
extends CharacterBody2D
class_name Ball


@export var fire_rate: float = 1
@export var launch_speed: int = 10
@export var _health: Health = Health.new()
@export var bounce: Bounce
@export var bounce_audio_player: OneShotAudioPlayer

@export var effects: Array[Effect]

@onready var _visible_on_screen_notifier_2D: VisibleOnScreenNotifier2D = NodeUtils.get_child_by_class(self, VisibleOnScreenNotifier2D)


func _ready() -> void:
	#reset_physics_interpolation()
	
	_visible_on_screen_notifier_2D.screen_exited.connect(_on_death)
	_health.died.connect(queue_free)


func _on_death() -> void:
	queue_free()


func take_damage(amount: int) -> void:
	_health.take_damage(amount)


func heal(amount: int) -> void:
	_health.heal(amount)
	
	
func apply_effects(effect_mofifiers: Dictionary) -> void:
	for effect in effects:
		effect_mofifiers = effect.apply(effect_mofifiers)
