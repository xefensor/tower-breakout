class_name Level
extends Node

signal enemies_cleared

static var instance: Level

@export var health: Health
@export var border: Area2D
@export var paths: Array[Path2D]

var money: int = 0:
	set(new_val):
		money = new_val
		level_ui.update_money_label(money)
var enemies_alive: int = 0:
	set(new_val):
		enemies_alive = maxi(0, new_val)
		if enemies_alive == 0:
			enemies_cleared.emit()

@onready var wave_controller: WaveController = NodeUtils.get_child_by_class(self, WaveController)
@onready var level_ui: LevelUI = NodeUtils.get_child_by_class(self, LevelUI)


func _enter_tree() -> void:
	instance = self
	

func _ready() -> void:
	border.border_crossed.connect(_on_crossed_border)
	health.health_changed.connect(_health_changed)
	wave_controller.wave_finished.connect(_on_wave_controller_wave_finished)
	
	level_ui.update_health_lavel(health.current_health)
	
	wave_controller.start_wave(wave_controller.wave_group.waves[0])


func _on_wave_controller_wave_finished() -> void:
	pass


func _on_crossed_border(damage: int) -> void:
	health.take_damage(damage)


func _health_changed(new_health: int) -> void:
	level_ui.update_money_label(new_health)


func on_enemy_tree_entered() -> void:
	enemies_alive += 1


func on_enemy_tree_exited() -> void:
	enemies_alive -= 1
