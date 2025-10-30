class_name PowerChooser
extends Resource


@export var powers: Array[Power]


func choose_power() -> Power:
	var chances_count: int = 0
	
	for power: Power in powers:
		chances_count += power.spawn_chance

	var rand: int = randi_range(0, chances_count-1)
	
	var cumulative: int = 0
	for power in powers:
		cumulative += power.spawn_chance
		if rand < cumulative:
			return power
	
	return null
