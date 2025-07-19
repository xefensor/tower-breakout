class_name Health
extends Resource


signal health_changed(new_health: int)
signal died()

@export var max_health: int = 5
@export var current_health: int = 5:
	set(new_health):
		current_health = new_health
		health_changed.emit(current_health)
		if current_health <= 0 and killable:
			died.emit()
@export var damageable: bool = true
@export var killable: bool = true
@export var healable: bool = true


func take_damage(amount: int) -> void:
	if damageable:
		current_health = max(current_health - amount, 0)


func heal(amount: int) -> void:
	if healable:
		current_health = min(current_health + amount, max_health)
