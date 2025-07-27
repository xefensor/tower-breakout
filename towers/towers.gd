class_name Towers
extends Node

@export var max_towers: int = 5
@export var vertical_position: int = 150
@export var starting_position: int = -320
@export var ending_position: int = 160
@export var towers: Array[Tower]


func _ready() -> void:
	setup_tower_positions()


func calulate_towers_spaceing():
	return (absi(starting_position) + absi(ending_position)) / (max_towers + 1)
	
	
func setup_tower_positions():
	var spacing = calulate_towers_spaceing()
	
	for i in max_towers:
		var new_tower = $Tower.duplicate()
		new_tower.position.y = vertical_position
		new_tower.position.x = starting_position + spacing + spacing * i
		towers.append(new_tower)
		add_child(new_tower)
	

func start_towers():
	for tower in towers:
		tower.start()
		
		
func stop_towers():
	for tower in towers:
		tower.stop()


func rotate_tower(tower: Tower, rotation: float):
	tower.rotation = clamp(rotation, -PI, 0)
