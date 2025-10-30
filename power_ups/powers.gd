class_name Powers
extends RefCounted


var powers: Array[Power]
var paddle: Paddle


func _init(_paddle: Paddle) -> void:
	paddle = _paddle


func handle_power(power: Power) -> void:
	power.paddle = paddle
	power.apply_effect()
