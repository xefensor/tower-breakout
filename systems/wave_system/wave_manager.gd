class_name	WaveManager
extends Node2D

@export var paths : Array[Path2D]
@export var waves : Array[Wave]

var waves_index = 0:
	set(new_val):
			waves_index = new_val
			if waves_index == waves.size():
				pass		

func _ready() -> void:
	await get_tree().create_timer(1.0, false).timeout


	
			
			
func _init() -> void:
	for wave in waves:
		wave.wave_finished.connect(_on_wave_finished)


func _on_wave_finished():
	waves_index += 1
