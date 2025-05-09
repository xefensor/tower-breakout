class_name EnemiesClearedCondition
extends WaveFinishCondition


var wave: Wave


func setup(_wave: Wave) -> void:
	wave = _wave
	wave.timelines_finished.connect(_on_timelines_finished)


func _on_timelines_finished() -> void:
	Level.instance.enemies_cleared.connect(check)
	check()


func check() -> void:
	if Level.instance.instance.enemies_alive == 0:
		_on_condition_met()
		condition_met.emit()


func _on_condition_met() -> void:
	wave.timelines_finished.disconnect(_on_timelines_finished)
	Level.instance.enemies_cleared.disconnect(check)
