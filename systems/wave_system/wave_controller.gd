class_name	WaveController
extends Node


signal wave_finished

@export var wave_group: WaveGroup
@export var autostart_nextwave: bool = true
@export var waves_transition_time: float = 5.0

var _current_wave_index: int = 0:
	set(new_val):
		_current_wave_index = clampi(new_val, 0, wave_group.waves.size()-1)


func start_wave(wave: Wave) -> void:
	get_tree().call_group("towers", "start")
	wave.wave_finished.connect(_on_wave_finished)
	wave.start()


func start_next_wave() -> void:
	if _current_wave_index >= wave_group.waves.size()-1:
		return
	_current_wave_index += 1
	await get_tree().create_timer(waves_transition_time, false).timeout
	start_wave(wave_group.waves[_current_wave_index])


func _on_wave_finished() -> void:
	get_tree().call_group("towers", "stop")
	
	wave_finished.emit()
	
	if wave_group.waves[_current_wave_index].wave_finished.is_connected(_on_wave_finished):
		wave_group.waves[_current_wave_index].wave_finished.disconnect(_on_wave_finished)
		
	if autostart_nextwave:
		start_next_wave()
