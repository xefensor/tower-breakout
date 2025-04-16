class_name WaveTimeline
extends Resource


signal timeline_finished


@export var timeline_objects : Array[WaveObject]
var objects_index = 0:
	set(new_val):
		if new_val >= timeline_objects.size():
			print("timeline finished")
			timeline_finished.emit()
			return
		objects_index = new_val
		start_object(timeline_objects[objects_index])

var wave_manager : WaveManager


func _on_object_finished():
	objects_index += 1


func start():
	start_object(timeline_objects[0])


func start_object(object : WaveObject):
	object.object_finished.connect(_on_object_finished)
	object.start(wave_manager)
