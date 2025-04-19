class_name Tower
extends Node2D

@onready var _timer : Timer = NodeUtils.get_child_by_class(self, Timer)
@export var ball : PackedScene
@export var spawn_ball_marker : Marker2D
@export var ball_start_speed : float = 200


func _ready() -> void:
	_timer.timeout.connect(_on_timer_timeout)


func _on_timer_timeout() -> void:
	var _inst = ball.instantiate()
	_inst.global_position = spawn_ball_marker.global_position
	get_parent().add_child(_inst)
	(_inst as Ball).velocity = Vector2.from_angle(rotation) * ball_start_speed
	
