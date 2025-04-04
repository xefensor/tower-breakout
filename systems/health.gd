## Health component for managing health, damage, and healing.
##
## This class provides a simple health system that supports taking damage, healing,
## and emitting signals when health changes or the entity is killed.
## It allows customization of whether the entity is damageable, healable, and killable.
##
## Example usage:
## [codeblock]
## var health = Health.new()
## health.take_damage(20)  # Reduces health by 20.
## health.heal(10)  # Increases health by 10.
## [/codeblock]
class_name Health
extends Node

## Emitted when the health value changes.
signal health_changed(new_health)

## Emitted when the entity is killed (health reaches 0 and [member is_killable] is true).
signal died()

## The maximum health value of the entity.
@export var max_health: int = 100

## The current health value. Triggers [signal health_changed] signal when modified.
## If health reaches 0 and [member is_killable] is true, the [signal killed] signal is emitted.
@export var current_health: int = 100:
	set(new_health):
		current_health = new_health
		health_changed.emit(current_health)
		if current_health <= 0 and is_killable:
			died.emit()

## Determines if the entity can take damage.
@export var is_damageable: bool = true

## Determines if the entity can be killed when health reaches 0.
@export var is_killable: bool = true

## Determines if the entity can be healed.
@export var is_healable: bool = true

## Reduces health by the given amount if [member is_damageable] is enabled.
## Ensures health does not drop below 0.
##
## Takes [param amount] as the amount of damage to take.
func take_damage(amount: int):
	if is_damageable:
		current_health = max(current_health - amount, 0)

## Increases health by the given amount if [member is_healable] is enabled.
## Ensures health does not exceed [member max_health].
##
## Takes [param amount] as the amount of health to restore.
func heal(amount: int):
	if is_healable:
		current_health = min(current_health + amount, max_health)


	
