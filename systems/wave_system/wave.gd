class_name Wave
extends Resource


signal wave_finished


@export var wave_timelines : Array[WaveTimeline]
var finished_timelines : int = 0:
	set(new_val):
		finished_timelines = new_val
		if finished_timelines == wave_timelines.size():
			wave_finished.emit()
			
			
func _init() -> void:
	for timeline in wave_timelines:
		timeline.timeline_finished.connect(_on_timeline_finished)


func _on_timeline_finished():
	finished_timelines += 1
