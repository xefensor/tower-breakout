class_name Tower
extends Node2D


signal selected(tower: Tower)

const lauch_speed_multiplier = 10

@export var spawn_ball_marker: Marker2D

var launch_speed: int = 1
var ball_health: int = 1
var ball: Ball

@onready var _timer: Timer = NodeUtils.get_child_by_class(self, Timer)
@onready var _area_2d: Area2D = NodeUtils.get_child_by_class(self, Area2D)


func _ready() -> void:
	_timer.timeout.connect(_on_timer_timeout)
	_area_2d.input_event.connect(_on_area_2d_input_event)
	
	set_ball(load("res://balls/ball_types/basic_ball_resource.tres"))
	set_stats(load("res://balls/ball_types/basic_ball_resource.tres"), [load("res://balls/effects/basic_hit_effect_resource.tres")])


func start() -> void:
	if _timer.is_stopped():
		_on_timer_timeout()
	
	_timer.start()
	
	
func stop() -> void:
	_timer.stop()


func _on_timer_timeout() -> void:
	var dup_ball: Ball = ball.duplicate()
	dup_ball.global_position = spawn_ball_marker.global_position
	dup_ball._health = Health.new()
	dup_ball._health.max_health = ball_health
	dup_ball._health.current_health = ball_health
	dup_ball.velocity = Vector2.from_angle(rotation) * launch_speed * lauch_speed_multiplier
	get_parent().add_child(dup_ball)
	
	
func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int)  -> void:
	if event.is_action_pressed("click"):
		print("click")
		selected.emit(self)


func set_stats(ball_res: BallResource, effects_res: Array[EffectResource]) -> void:
	var effects_fire_rate: float = 0
	var effects_launch_speed: int = 0
	var effects_health: int = 0
	
	for effect in effects_res:
		effects_fire_rate += effect.fire_rate_mod
		effects_launch_speed += effect.launch_speed_mod
		effects_health += effect.health_mod
	
	_timer.wait_time = ball_res.fire_rate + effects_fire_rate
	launch_speed = ball_res.launch_speed + effects_launch_speed
	ball_health = ball_res.health + effects_health


func set_ball(ball_res: BallResource) -> void:
	ball = ball_res.scene.instantiate()
