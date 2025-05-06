class_name OneShotAudioPlayer
extends AudioStreamPlayer


func one_shot_play(parent_node: Node = self) -> void:
	var player = duplicate()
	player.finished.connect(player.queue_free)
	parent_node.add_child(player)
	player.play()
