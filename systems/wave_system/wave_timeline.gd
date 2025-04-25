class_name WaveTimeline
extends Resource


signal timeline_finished

@export var timeline_objects : Array[WaveObject]
var objects_index = 0:
	set(new_val):
		objects_index = clampi(new_val, 0, timeline_objects.size()-1)
		
var wave_manager : WaveManager


func start():
	start_object(timeline_objects[0])


func start_object(object : WaveObject):
	object.object_finished.connect(_on_object_finished)
	object.start(wave_manager)


func start_next_object():
	if objects_index >= timeline_objects.size()-1:
		print("timeline finished")
		timeline_finished.emit()
		return
	objects_index += 1
	start_object(timeline_objects[objects_index])


func _on_object_finished():
	timeline_objects[objects_index].object_finished.disconnect(_on_object_finished)
	start_next_object()
