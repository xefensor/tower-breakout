## Applies a burn effect to the target, dealing damage over time.
##
## This class extends the `StatusEffect` class and adds functionality for dealing
## damage over time (DoT) to the target node. The damage is applied every frame
## based on the `dps` (damage per second) value.

class_name BurnEffect
extends StatusEffect

## Damage per second dealt by the burn effect.
##
## The amount of damage dealt every second to the target. A value of 5.0 means
## the target will take 5 damage per second.
@export var dps: float = 5.0

### Updates the burn effect by applying damage to the target each frame.
##
## [param delta]: The time elapsed since the last frame. The damage is scaled based
## on the time that has passed to simulate damage over time.
func tick(delta: float) -> void:
	super.tick(delta)
	if owner and "apply_damage" in owner:
		owner.apply_damage(dps * delta)
