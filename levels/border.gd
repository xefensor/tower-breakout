class_name Border
extends Area2D


signal crossed_border(damage: int)


func _ready() -> void:
	body_exited.connect(_on_body_exited)
	
	
func _on_body_exited(body: Node2D) -> void:
	if body is Enemy:
		var _enemy = body as Enemy
		_enemy.set_collision_layer_value(6, false)
		crossed_border.emit(_enemy._health.current_health)
