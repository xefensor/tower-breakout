## Slows down the target by a certain percentage of its speed.
##
## This class applies a slow effect to the entity that has the `add_speed_modifier` method.
## Once the effect is stopped, the speed modification is removed using `remove_speed_modifier`.

class_name SlowEffect
extends StatusEffect

## Slow intensity.
##
## A value of 0.4 means the target's speed will be reduced by 40%.
## The range should be between 0.0 (no slow) and 1.0 (complete stop).
@export var intensity: float = 0.4

### Starts the slow effect on the target node.
## 
## [param target]: The node that the slow effect should be applied to. It should implement the `add_speed_modifier(effect, multiplier)` method.
func start(target: Node) -> void:
	super.start(target)
	if "add_speed_modifier" in target:
		target.add_speed_modifier(self, 1.0 - intensity)

### Stops the slow effect and removes the speed modification from the original target.
func stop() -> void:
	if owner and "remove_speed_modifier" in owner:
		owner.remove_speed_modifier(self)
