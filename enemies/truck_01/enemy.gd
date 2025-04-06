class_name Enemy
extends AnimatableBody2D


signal died()


@onready var _health : Health = NodeUtils.get_child_by_class(self, Health) as Health
@onready var _health_bar : TextureProgressBar = NodeUtils.get_child_by_class(self, TextureProgressBar) as TextureProgressBar

@export var progression_speed: float = 10
@export var damage_to_base: int = 5


func _ready() -> void:
	reset_physics_interpolation()
	
	_health.died.connect(_on_death)
	_health.health_changed.connect(_on_health_changed)


func take_damage(amount: float) -> void:
	_health.take_damage(amount)


func _on_death() -> void:
	died.emit()
	queue_free()


func _on_health_changed(value:int):
	_health_bar.value = 100 /_health.max_health * value
