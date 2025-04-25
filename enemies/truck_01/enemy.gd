class_name Enemy
extends AnimatableBody2D


signal died()


@export var _health : Health = Health.new()
@export var paddle_damage : int = 1
@onready var _health_bar : TextureProgressBar = NodeUtils.get_child_by_class(self, TextureProgressBar) as TextureProgressBar
@export var explosion_sound : AudioStreamWrapper
@export var sprite_frames : SpriteFrames


func _ready() -> void:
	reset_physics_interpolation()
	
	_health.died.connect(_on_death)
	_health.health_changed.connect(_on_health_changed)


func take_damage(amount: float) -> void:
	_health.take_damage(amount)


func _on_death() -> void:
	died.emit()
	EffectManager.create_and_play_audio(explosion_sound)
	EffectManager.create_and_play_animatable_sprite(sprite_frames, "default", self.global_position, 5)
	queue_free()


func _on_health_changed(value:int):
	_health_bar.value = 100 /_health.max_health * value
