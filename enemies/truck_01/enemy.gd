class_name Enemy
extends AnimatableBody2D


signal died()

@export var _health: Health = Health.new()
@export var paddle_damage: int = 1
@export var explosion_audio_player: OneShotAudioPlayer
@export var explosion_sprite: OneShotAnimatedSprite2D

@onready var _health_bar: TextureProgressBar = NodeUtils.get_child_by_class(self, TextureProgressBar)


func _ready() -> void:
	reset_physics_interpolation()
	
	_health.died.connect(_on_death)
	_health.health_changed.connect(_on_health_changed)
	
	_health_bar.value = 100 /_health.max_health * _health.current_health


func take_damage(amount: float) -> void:
	_health.take_damage(amount)


func die():
	_health.current_health = 0


func _on_death() -> void:
	died.emit()
	explosion_audio_player.one_shot_play(Level.current_level)
	explosion_sprite.one_shot_play(Level.current_level)
	queue_free()


func _on_health_changed(new_health : int) -> void:
	_health_bar.value = 100 /_health.max_health * new_health
