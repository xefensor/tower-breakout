class_name WaveEnemy
extends WaveObject

@export var enemy : PackedScene
@export var amount : int = 1
@export var path : int = 0
@export var delay : float = 0
var enemy_index = 0:
	set(new_val):
		enemy_index = clamp(new_val, 0, amount-1)
