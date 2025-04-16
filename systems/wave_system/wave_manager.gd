class_name	WaveManager
extends Node2D

signal enemies_cleared


@export var paths : Array[Path2D]
@export var waves : Array[Wave]

var _current_wave_index = 0:
	set(new_val):
		_current_wave_index = 	clampi(new_val, 0, waves.size()-1)

var enemies_alive : int = 0:
	set(new_val):
		enemies_alive = maxi(0, new_val)
		if enemies_alive == 0:
			enemies_cleared.emit()

	
func _ready() -> void:
	start_wave(waves[0])	
	

func _on_wave_finished():
	if waves[_current_wave_index].wave_finished.is_connected(_on_wave_finished):
		waves[_current_wave_index].wave_finished.disconnect(_on_wave_finished)
	start_next_wave()


func start_wave(wave : Wave):
	wave.wave_manager = self
	wave.wave_finished.connect(_on_wave_finished)
	wave.start()


func start_next_wave():
	_current_wave_index += 1
	start_wave(waves[_current_wave_index])


func on_enemy_freed():
	enemies_alive -= 1
