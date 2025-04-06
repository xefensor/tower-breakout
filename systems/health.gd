class_name Health
extends Node

signal health_changed(new_health)
signal died()

@export var max_health: int = 100
@export var current_health: int = 100:
	set(new_health):
		current_health = new_health
		health_changed.emit(current_health)
		if current_health <= 0 and is_killable:
			died.emit()
@export var is_damageable: bool = true
@export var is_killable: bool = true
@export var is_healable: bool = true


func take_damage(amount: int):
	if is_damageable:
		current_health = max(current_health - amount, 0)


func heal(amount: int):
	if is_healable:
		current_health = min(current_health + amount, max_health)
