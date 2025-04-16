class_name EnemiesClearedCondition
extends WaveFinishCondition


var wave : Wave


func setup(_wave: Wave) -> void:
	wave = _wave
	wave.timelines_finished.connect(_on_timelines_finished)


func _on_timelines_finished():
	wave.wave_manager.enemies_cleared.connect(check)
	check()


func check() -> void:
	if wave.wave_manager.enemies_alive == 0:
		_on_condition_met()
		condition_met.emit()


func _on_condition_met():
	wave.timelines_finished.disconnect(_on_timelines_finished)
	wave.wave_manager.enemies_cleared.disconnect(check)
