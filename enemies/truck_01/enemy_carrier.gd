extends PathFollow2D

signal end_reached


## The speed at which the enemy progresses along the path.
##
## This value determines how fast the enemy moves along the path. 
## A higher value means the enemy moves faster.
@export var progression_speed: float = 10

@onready var _enemy : Enemy = $Enemy as Enemy

func _ready() -> void:
	_enemy.died.connect(queue_free)


func _physics_process(delta: float) -> void:
	progress += progression_speed * delta

	# Check if the enemy has reached the base
	if progress_ratio >= 1:
		end_reached.emit()
		queue_free()
