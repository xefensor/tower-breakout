class_name PowerChooser
extends Resource

@export var powers: Array[Power]

func choose_power():
	var chances_count: int
	
	for power in powers:
		chances_count += power.spawn_chance

	var rand = randi_range(0, chances_count-1)
	
	var cumulative := 0
	for power in powers:
		cumulative += power.spawn_chance
		if rand < cumulative:
			return power
