class_name Wave
extends Resource


signal wave_finished


enum WaveFinishedConditions {ENEMIES_CLEARED, TIMER}

@export var wave_timelines : Array[WaveTimeline]
var finished_timelines : int = 0:
	set(new_val):
		finished_timelines = new_val
		if finished_timelines == wave_timelines.size():
			_on_timelines_finished()
@export var wave_finished_condition : WaveFinishedConditions = WaveFinishedConditions.ENEMIES_CLEARED
var wave_manager : WaveManager


func _on_timeline_finished():
	finished_timelines += 1


func _on_timelines_finished():
	match wave_finished_condition:
		WaveFinishedConditions.ENEMIES_CLEARED:
			wave_manager.enemies_cleared.connect(check_finished_condition)
			check_finished_condition()
			

func check_finished_condition():
	match wave_finished_condition:
		WaveFinishedConditions.ENEMIES_CLEARED:
			if not finished_timelines >= wave_timelines.size() or not wave_manager.enemies_alive == 0:
				return
			wave_manager.enemies_cleared.disconnect(check_finished_condition)	
		_:
			return
	
	print("wave finished")
	wave_finished.emit()


func start():
	start_timelines()


func start_timelines():
	for timeline in wave_timelines:
		timeline.wave_manager = wave_manager
		timeline.timeline_finished.connect(_on_timeline_finished)
		timeline.start()
