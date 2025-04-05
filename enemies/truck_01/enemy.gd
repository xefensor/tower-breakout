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
## [param damage]: The amount of damage inflicted on the base.
signal base_reached(damage: int)

## Health component of the enemy.
@onready var _health : Health = $Health as Health

## The speed at which the enemy progresses along the path.
##
## This value determines how fast the enemy moves along the path. 
## A higher value means the enemy moves faster.
@export var progression_speed: float = 10

## The amount of damage the enemy deals to the base upon reaching it.
##
## This value specifies how much damage the enemy will inflict on the base when it reaches the end of the path.
@export var damage_to_base: int = 5

## The list of active status effects currently affecting the enemy.
##
## These effects are applied to the enemy and are updated each frame.
var active_effects: Array[StatusEffect] = []

## Dictionary of speed modifiers applied to the enemy.
##
## This stores the speed modifiers and their respective sources. These modifiers are multiplied together to calculate the enemy's total speed.
var speed_modifiers := {}

## Called when the node enters the scene tree.
##
## Initializes physics interpolation and connects the death signal of the enemy to a handler.
func _ready() -> void:
	reset_physics_interpolation()
	_health.died.connect(_on_death)

## Updates the enemy's position along the path.
##
## This function moves the enemy along the path, considering any active speed modifiers and effects.
## If the enemy reaches the end of the path, it emits the [signal base_reached] and removes itself from the scene.
##
## [param delta]: The frame time step used to update the position.
func _physics_process(delta: float) -> void:
	# Update the effects
	for effect in active_effects:
		effect.tick(delta)

	# Remove finished effects
	active_effects = active_effects.filter(func(e):
		if e.is_finished():
			e.stop()
			return false
		return true)

	# Calculate the total speed and update progress along the path
	var speed = progression_speed * _get_total_speed_multiplier()
	progress += speed * delta

	# Check if the enemy has reached the base
	if progress_ratio >= 1:
		_on_base_reached()

## Returns the total speed multiplier considering all speed modifiers.
##
## This function multiplies all active speed modifiers to calculate the total speed multiplier.
## [return]: The total speed multiplier applied to the enemy.
func _get_total_speed_multiplier() -> float:
	var total := 1.0
	for mult in speed_modifiers.values():
		total *= mult
	return total

## Adds a speed modifier to the enemy.
##
## [param source]: The object that is applying the speed modifier.
## [param mult]: The speed modifier multiplier to apply.
func add_speed_modifier(source: Object, mult: float) -> void:
	speed_modifiers[source] = mult

## Removes a speed modifier from the enemy.
##
## [param source]: The object whose speed modifier should be removed.
func remove_speed_modifier(source: Object) -> void:
	speed_modifiers.erase(source)

## Applies a status effect to the enemy.
##
## [param effect]: The status effect to be applied to the enemy.
func apply_effect(effect: StatusEffect) -> void:
	effect.start(self)
	active_effects.append(effect)

## Removes a status effect from the enemy.
##
## [param effect]: The status effect to be removed from the enemy.
func remove_effect(effect: StatusEffect) -> void:
	if effect in active_effects:
		effect.stop()
		active_effects.erase(effect)

## Applies damage to the enemy's health.
##
## [param amount]: The amount of damage to apply to the enemy.
func apply_damage(amount: float) -> void:
	_health.take_damage(amount)

### Called when the enemy reaches the base.
##
## Emits the [signal base_reached] with the damage inflicted to the base.
func _on_base_reached() -> void:
	emit_signal("base_reached", damage_to_base)
	queue_free()

## Called when the enemy's health reaches zero (death).
##
## Removes the enemy from the scene when it dies.
func _on_death() -> void:
	queue_free()
