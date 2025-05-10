class_name Border
extends Area2D


signal border_crossed(damage: int)


func _ready() -> void:
	body_exited.connect(_on_body_exited)
	
	
func _on_body_exited(body: Node2D) -> void:
	if body is Enemy:
		var _enemy = body as Enemy
		_enemy.health.damageable = false
		border_crossed.emit(_enemy.health.current_health)
