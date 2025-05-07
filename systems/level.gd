class_name Level
extends Node


static var current_level : Node

@export var _health: Health
@export var health_label: Label
@export var border: Area2D

@onready var _wave_manager: WaveManager = NodeUtils.get_child_by_class(self, WaveManager)


func _ready() -> void:
	border.crossed_border.connect(_on_crossed_border)
	_health.health_changed.connect(_health_changed)
	
	health_label.text = str(_health.current_health)
	
	_wave_manager.start_wave(_wave_manager.waves[0])
	
	current_level = self


func _on_crossed_border(damage: int) -> void:
	_health.take_damage(damage)


func _health_changed(new_health: int) -> void:
	health_label.text = str(new_health)
