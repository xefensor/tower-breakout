class_name Tower
extends Node2D


signal selected(tower: Tower)

const lauch_speed_multiplier = 10

@export var ball_scene: PackedScene
@export var spawn_ball_marker: Marker2D

var launch_speed: int = 1
var ball_health: int = 1

@onready var _timer: Timer = NodeUtils.get_child_by_class(self, Timer)
@onready var _area_2d: Area2D = NodeUtils.get_child_by_class(self, Area2D)


func _ready() -> void:
	_timer.timeout.connect(_on_timer_timeout)
	_area_2d.input_event.connect(_on_area_2d_input_event)
	
	set_stats()


func start() -> void:
	_timer.start()
	
	
func stop() -> void:
	_timer.stop()


func _on_timer_timeout() -> void:
	var inst: Ball = ball_scene.instantiate()
	inst.global_position = spawn_ball_marker.global_position
	inst._health.max_health = ball_health
	inst._health.current_health = ball_health
	inst.velocity = Vector2.from_angle(rotation) * launch_speed * lauch_speed_multiplier
	get_parent().add_child(inst)
	
	
func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int)  -> void:
	if event.is_action_pressed("click"):
		print("click")
		selected.emit(self)


func set_stats() -> void:
	var ball: Ball = ball_scene.instantiate()
	
	var effects_fire_rate: float = 0
	var effects_launch_speed: int = 0
	var effects_health: int = 0
	
	for effect in ball.effects:
		effects_fire_rate += effect.fire_rate_mod
		effects_launch_speed += effect.launch_speed_mod
		effects_health += effect.health_mod
	
	_timer.wait_time = ball.fire_rate + effects_fire_rate
	launch_speed = ball.launch_speed + effects_launch_speed
	ball_health = ball._health.max_health + effects_health
