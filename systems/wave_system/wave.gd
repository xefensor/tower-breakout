class_name Wave
extends Resource


signal wave_finished
signal timelines_finished


@export var finish_condition : WaveFinishCondition = EnemiesClearedCondition.new()
@export var wave_finished_delay : float = 5.0
@export var wave_timelines : Array[WaveTimeline]
var finished_timelines : int = 0:
	set(new_val):
		finished_timelines = new_val
		if finished_timelines == wave_timelines.size():
			timelines_finished.emit()
var wave_manager : WaveManager


func _on_timeline_finished():
	finished_timelines += 1


func start():
	finish_condition.condition_met.connect(_on_condition_met)
	finish_condition.setup(self)
	start_timelines()


func start_timelines():
	for timeline in wave_timelines:
		timeline.wave_manager = wave_manager
		timeline.timeline_finished.connect(_on_timeline_finished)
		timeline.start()



func _on_condition_met():
	finish_condition.condition_met.disconnect(_on_condition_met)
	await wave_manager.get_tree().create_timer(wave_finished_delay, false).timeout
	print("wave finished")
	wave_finished.emit()
	
