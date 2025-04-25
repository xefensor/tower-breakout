class_name WaveTimer
extends WaveObject


@export var time: float 


func start(manager: WaveManager) -> void:
	await manager.get_tree().create_timer(time, false).timeout
	object_finished.emit()
