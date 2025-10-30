@abstract
class_name Power
extends Resource


enum Type {POWER_UP, POWER_DOWN}

@export var type: Type = Type.POWER_UP
@export var spawn_chance: int = 1
@export var sprite: Texture2D = preload("res://icon.svg") 

var paddle: Paddle


func apply_effect() -> void:
	pass
	
	
func remove_effect() -> void:
	pass
