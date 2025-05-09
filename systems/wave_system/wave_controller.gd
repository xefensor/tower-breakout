class_name	WaveController
extends Resource


signal wave_finished

@export var waves: Array[Wave]
@export var autostart_nextwave: bool = true
@export var waves_transition_time: float = 5.0

var _current_wave_index: int = 0:
	set(new_val):
		_current_wave_index = clampi(new_val, 0, waves.size()-1)


func _ready() -> void:
	#start_wave(waves[0])
	pass
	

func start_wave(wave: Wave) -> void:
	wave.wave_finished.connect(_on_wave_finished)
	wave.start()


func start_next_wave() -> void:
	if _current_wave_index >= waves.size()-1:
		return
	_current_wave_index += 1
	await Level.instance.get_tree().create_timer(waves_transition_time, false).timeout
	start_wave(waves[_current_wave_index])


func _on_wave_finished() -> void:
	wave_finished.emit()
	if waves[_current_wave_index].wave_finished.is_connected(_on_wave_finished):
		waves[_current_wave_index].wave_finished.disconnect(_on_wave_finished)
		
	if autostart_nextwave:
		start_next_wave()
