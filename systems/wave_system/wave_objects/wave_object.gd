class_name WaveObject
extends Resource


signal object_finished


func start() -> void:
	object_finished.emit()
