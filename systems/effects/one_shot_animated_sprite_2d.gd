class_name OneShotAnimatedSprite2D
extends AnimatedSprite2D


func one_shot_play(parent_node: Node = self):
	var sprite = duplicate()
	sprite.animation_finished.connect(sprite.queue_free)
	sprite.global_position = global_position
	parent_node.add_child(sprite)
	sprite.visible = true
	sprite.play()
