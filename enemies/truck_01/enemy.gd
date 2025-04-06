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
extends AnimatableBody2D


signal died()

## Health component of the enemy.
@onready var _health : Health = $Health as Health

## Health component of the enemy.
@onready var _health_bar : TextureProgressBar = $TextureProgressBar as TextureProgressBar

var _path_follow_2d : PathFollow2D

## The speed at which the enemy progresses along the path.
##
## This value determines how fast the enemy moves along the path. 
## A higher value means the enemy moves faster.
@export var progression_speed: float = 10

## The amount of damage the enemy deals to the base upon reaching it.
##
## This value specifies how much damage the enemy will inflict on the base when it reaches the end of the path.
@export var damage_to_base: int = 5

## Called when the node enters the scene tree.
##
## Initializes physics interpolation and connects the death signal of the enemy to a handler.
func _ready() -> void:
	reset_physics_interpolation()
	_health.died.connect(_on_death)
	_health.health_changed.connect(_on_health_changed)

## Applies damage to the enemy's health.
##
## [param amount]: The amount of damage to apply to the enemy.
func take_damage(amount: float) -> void:
	_health.take_damage(amount)

## Called when the enemy's health reaches zero (death).
##
## Removes the enemy from the scene when it dies.
func _on_death() -> void:
	died.emit()
	queue_free()


func _on_health_changed(value:int):
	_health_bar.value = 100 /_health.max_health * value
