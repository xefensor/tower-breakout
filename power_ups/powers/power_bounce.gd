class_name PowerBounce
extends Power


@export var strenght: float = 0.1
@export var time: float = 5


func apply_effect() -> void:
	if positive:
		paddle.bounce_strenght += strenght
	else:
		paddle.bounce_strenght -= strenght
	
	await paddle.get_tree().create_timer(time).timeout
	remove_effect()
	
	
func remove_effect() -> void:
	if positive:
		paddle.bounce_strenght -= strenght
	else:
		paddle.bounce_strenght += strenght
