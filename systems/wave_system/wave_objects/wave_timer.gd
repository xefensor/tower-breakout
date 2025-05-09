class_name WaveTimer
extends WaveObject


@export var time: float 


func start() -> void:
	await Level.instance.get_tree().create_timer(time, false).timeout
	object_finished.emit()
