class_name OneShotAnimatedSprite2D
extends AnimatedSprite2D


func one_shot_play(parent_node: Node = self) -> void:
	var sprite: OneShotAnimatedSprite2D = duplicate()
	sprite.animation_finished.connect(sprite.queue_free)
	sprite.global_position = global_position
	sprite.visible = true
	parent_node.add_child(sprite)
	sprite.reset_physics_interpolation()
	sprite.play()
