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
		start_object(objects_index)

var wave_manager : WaveManager


func _on_object_finished():
	objects_index += 1


func start_object(index : int):
	wave_manager.do_object(self, timeline_objects[index])


func set_wave_manager(manager: WaveManager):
	wave_manager = manager
