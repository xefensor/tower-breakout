class_name Level
extends Node

signal enemies_cleared

static var instance: Level

@export var base_health: Health
@export var health_label: Label
@export var border: Area2D
@export var paths: Array[Path2D]
@export var wave_controller: WaveController = WaveController.new()

var enemies_alive: int = 0:
	set(new_val):
		enemies_alive = maxi(0, new_val)
		if enemies_alive == 0:
			enemies_cleared.emit()


func _init() -> void:
	instance = self
	

func _ready() -> void:
	border.crossed_border.connect(_on_crossed_border)
	base_health.health_changed.connect(_health_changed)
	
	health_label.text = str(base_health.current_health)
	
	wave_controller.start_wave(wave_controller.waves[0])


func _on_crossed_border(damage: int) -> void:
	base_health.take_damage(damage)


func _health_changed(new_health: int) -> void:
	health_label.text = str(new_health)


func on_enemy_tree_entered() -> void:
	enemies_alive += 1


func on_enemy_tree_exited() -> void:
	enemies_alive -= 1
