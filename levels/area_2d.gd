extends Area2D


func _ready() -> void:
	body_exited.connect(_on_body_exited)
	
	
func _on_body_exited(body : Node2D):
	if body is Ball:
		(body as Ball).set_collision_layer_value(3, true)
		(body as Ball).set_collision_layer_value(4, false)
