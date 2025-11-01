class_name Wave
extends Resource


signal wave_finished
signal timelines_finished

@export var finish_condition: WaveFinishCondition = EnemiesClearedCondition.new()
@export var wave_timelines: Array[WaveTimeline]

var finished_timelines: int = 0:
	set(new_val):
		finished_timelines = new_val
		if finished_timelines != wave_timelines.size():
			return
		for timeline in wave_timelines:
			timeline.timeline_finished.disconnect(_on_timeline_finished)
		timelines_finished.emit()


func start() -> void:
	print("wave start")
	finish_condition.condition_met.connect(_on_condition_met)
	finish_condition.setup(self)
	start_timelines()


func start_timelines() -> void:
	for timeline in wave_timelines:
		timeline.timeline_finished.connect(_on_timeline_finished)
		timeline.start()


func _on_timeline_finished() -> void:
	finished_timelines += 1


func _on_condition_met() -> void:
	finish_condition.condition_met.disconnect(_on_condition_met)
	print("wave finished")
	wave_finished.emit()
