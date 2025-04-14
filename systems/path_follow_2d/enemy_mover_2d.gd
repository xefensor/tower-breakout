class_name EnemyMover2D
extends PathMover2D


@export var _enemy : Enemy = NodeUtils.get_child_by_class(self, Enemy) as Enemy
@export var damage_to_base: int = 5


func _ready() -> void:
	reset_physics_interpolation()
	
	if _enemy:
		_enemy.died.connect(queue_free)
