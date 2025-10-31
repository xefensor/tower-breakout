@abstract
class_name Power
extends Resource


@export var positive: bool = true
@export var sprite: Texture2D = preload("res://icon.svg") 

var paddle: Paddle


@abstract
func apply_effect() -> void
