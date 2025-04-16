class_name WaveObject
extends Resource


signal object_finished


func start(manager : WaveManager):
	object_finished.emit()
