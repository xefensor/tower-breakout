class_name Wave
extends Resource


signal wave_finished


@export var wave_timelines : Array[WaveTimeline]
var finished_timelines : int = 0:
	set(new_val):
		if new_val >= wave_timelines.size():
			print("wave finished")
			wave_finished.emit()
			return
		finished_timelines = new_val


func _on_timeline_finished():
	finished_timelines += 1


func start_timelines():
	for timeline in wave_timelines:
		timeline.timeline_finished.connect(_on_timeline_finished)
		timeline.start_object(0)


func set_wave_manager(manager: WaveManager):
	for timeline in wave_timelines:
		timeline.set_wave_manager(manager)
