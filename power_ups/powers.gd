class_name Powers
extends Resource


@export var powers: Array[PowerAndChance]


func calc_combined_chance(_powers: Array[PowerAndChance]) -> int:
	var chance: int = 0
	
	for power_and_change: PowerAndChance in _powers:
		chance += power_and_change.spawn_chance

	return chance
	

func choose_power(_powers: Array[PowerAndChance]) -> Power:
	var combined_chance: int =  calc_combined_chance(_powers)
	var spawn_chance: int = randi_range(1, 100)
	
	if spawn_chance > combined_chance:
		return
	
	var finding_power: int = 0
	for power_and_chance in _powers:
		finding_power += power_and_chance.spawn_chance
		if spawn_chance <= finding_power:
			return power_and_chance.power
		
	return null
