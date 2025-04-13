class_name WaveTimeline
extends Resource


signal timeline_finished


@export var timeline_objects : Array[WaveObject]
var objects_index = 0:
	set(new_val):
		objects_index = new_val
		if objects_index == timeline_objects.size():
			timeline_finished.emit()			
			
			
func _init() -> void:
	for object in timeline_objects:
		object.object_finished.connect(_on_object_finished)


func _on_object_finished():
	objects_index += 1
