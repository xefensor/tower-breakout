class_name Tower
extends Node2D


@export var ball: PackedScene
@export var spawn_ball_marker: Marker2D
@export var launch_power: float = 1

@onready var _timer: Timer = NodeUtils.get_child_by_class(self, Timer)
@onready var _area_2d: Area2D = NodeUtils.get_child_by_class(self, Area2D)


func _ready() -> void:
	_timer.timeout.connect(_on_timer_timeout)
	_area_2d.input_event.connect(_on_area_2d_input_event)


func _on_timer_timeout() -> void:
	var _inst: Ball = ball.instantiate()
	_inst.global_position = spawn_ball_marker.global_position
	get_parent().add_child(_inst)
	_inst.velocity = Vector2.from_angle(rotation) * (_inst.start_speed * launch_power)
	

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if event.is_action_pressed("click"):
		pass
	
