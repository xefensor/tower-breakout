class_name DamageableStaticBody2D
extends StaticBody2D


@export var health: Health = Health.new()


func _ready() -> void:
	health.died.connect(_on_health_died)


func take_damage(amount: float) -> void:
	health.take_damage(amount)


func _on_health_died() -> void:
	queue_free()
