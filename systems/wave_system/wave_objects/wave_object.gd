class_name WaveObject
extends Resource


signal object_finished


func start(manager: WaveManager) -> void:
	object_finished.emit()
