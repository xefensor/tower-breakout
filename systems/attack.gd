## Represents an attack that deals damage and applies status effects to a target.
##
## This class encapsulates the concept of an attack, which can deal damage to a node
## and apply additional status effects from the `effects` array. The `apply_to` method
## handles both the damage application and the application of each effect.

class_name Attack
extends Resource

## The amount of damage dealt by the attack.
##
## The damage value that will be applied to the target when the attack is used. 
## A value of 10 means the target will take 10 points of damage.
@export var damage: int = 10

## The list of status effects to be applied to the target.
##
## This array holds instances of `StatusEffect` (or its subclasses), which will be 
## applied to the target when the attack is performed. Each effect will be instantiated
## and applied individually.
@export var effects: Array[StatusEffect] = []

### Applies the attack to the specified target node.
##
## [param target]: The node that will receive the damage and effects. 
## It must have the methods `apply_damage` and `apply_effect` to process the attack.
func apply_to(target: Node) -> void:
	if target.has_method("apply_damage"):
		target.apply_damage(damage)
	for effect in effects:
		var instance := effect.duplicate()  # Create a new instance of the effect
		if target.has_method("apply_effect"):
			target.apply_effect(instance)
