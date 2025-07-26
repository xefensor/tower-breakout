class_name Towers
extends Node

@export var towers: Array[Tower]


func start_towers():
	for tower in towers:
		tower.start()
		
		
func stop_towers():
	for tower in towers:
		tower.stop()


func rotate_tower(tower: Tower, rotation: float):
	tower.rotation = clamp(rotation, -PI, 0)
