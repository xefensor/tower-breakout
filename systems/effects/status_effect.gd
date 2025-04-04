## Base class for status effects that can be applied to nodes.
##
## This class manages the duration of a status effect, tracks its elapsed time,
## and provides methods to start, update, check if the effect is finished, and stop it.

class_name StatusEffect
extends Resource

## Duration of the status effect in seconds.
##
## The effect will last for the specified duration. 
## A value of 1.0 means the effect will last for one second.
@export var duration: float = 1.0

## Time elapsed since the effect started.
##
## This variable keeps track of how much time has passed since the effect started.
var elapsed_time := 0.0

## The node that owns this effect.
##
## This is typically the target of the effect, where the effect is applied.
var owner: Node = null

### Starts the status effect on the target node.
## 
## [param target]: The node to which the effect is applied. This is set as the `owner` of the effect.
func start(target: Node) -> void:
	owner = target

### Updates the effect by adding the delta time to the elapsed time.
##
## [param delta]: The time elapsed since the last frame, used to update the effect's progress.
func tick(delta: float) -> void:
	elapsed_time += delta

### Checks if the effect has finished based on the elapsed time and duration.
##
## Returns `true` if the effect's duration has passed, otherwise `false`.
func is_finished() -> bool:
	return elapsed_time >= duration

### Stops the status effect. Can be overridden by subclasses to implement custom stop behavior.
func stop() -> void:
	pass
