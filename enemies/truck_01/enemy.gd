## Enemy component for handling movement along a path and reaching the base.
##
## This class extends [PathFollow2D] to move along a predefined path at a given speed.
## When the enemy reaches the end of the path, it emits a signal indicating damage to the base
## and is removed from the scene.
##
## Example usage:
## [codeblock]
## var enemy = Enemy.new()
## enemy.progression_speed = 15
## enemy.damage_to_base = 10
## [/codeblock]
class_name Enemy
extends PathFollow2D


## Emitted when the enemy reaches the base, dealing damage.
##
## Takes [param damage] as the amount of damage inflicted on the base.
signal base_reached(damage: int)

## Health component of enemy
@onready var _health : Health = $Health as Health

## The speed at which the enemy progresses along the path.
@export var progression_speed: float = 10

## The amount of damage the enemy deals to the base upon reaching it.
@export var damage_to_base: int = 5

## Called when the node enters the scene tree.
## Ensures smooth physics interpolation.
func _ready() -> void:
	reset_physics_interpolation()
	_health.died.connect(_on_death)

## Updates the enemy's position along the path.
## If the enemy reaches the end, it emits the [signal reached_base] and removes itself from the scene.
##
## Takes [param delta] as the frame time step.
func _physics_process(delta: float) -> void:
	progress += progression_speed * delta
	if progress_ratio >= 1:
		_on_base_reached()
		queue_free()



func take_damage(amount : int):
	_health.take_damage(amount)
	
	
func heal(amount : int):
	_health.heal(amount)


## Called when enemy dies
func _on_death() -> void:
	queue_free()


func _on_base_reached():
	base_reached.emit(damage_to_base)
	queue_free()
