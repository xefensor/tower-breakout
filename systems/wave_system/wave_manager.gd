class_name	WaveManager
extends Node2D

@export var paths : Array[Path2D]
@export var waves : Array[Wave]

var waves_index = 0:
	set(new_val):
			if new_val >= waves.size():
				print("waves finished")
				return
			waves_index = new_val	
			start_wave(waves_index)

	
func _ready() -> void:
	set_wave_managers()
	start_wave(waves_index)	
	

func _on_wave_finished():
	waves_index += 1


func start_wave(index : int):
	waves[index].wave_finished.connect(_on_wave_finished)
	waves[index].start_timelines()


func do_object(timeline: WaveTimeline, wave_object : WaveObject):
	if wave_object is WaveTimer:
		await get_tree().create_timer((wave_object as WaveTimer).time, false).timeout
	elif wave_object is WaveEnemy:
		var object = wave_object as WaveEnemy
		for i in object.amount:
			var enemy = object.enemy.instantiate()
			paths[object.path].add_child(enemy)
			await get_tree().create_timer(object.delay, false).timeout
			
	timeline._on_object_finished()


func set_wave_managers():
	for wave in waves:
		wave.set_wave_manager(self)
