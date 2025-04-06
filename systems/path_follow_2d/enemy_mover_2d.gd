class_name EnemyMover2D
extends PathMover2D


@export var _enemy : Enemy = NodeUtils.get_child_by_class(self, Enemy) as Enemy


func _ready() -> void:
	if _enemy:
		_enemy.died.connect(queue_free)
