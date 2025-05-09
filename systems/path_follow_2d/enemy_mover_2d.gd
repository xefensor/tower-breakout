class_name EnemyMover2D
extends PathMover2D


@onready var _enemy: Enemy = NodeUtils.get_child_by_class(self, Enemy)


func _ready() -> void:
	super._ready()
	
	if _enemy:
		_enemy.died.connect(_on_died)


func _physics_process(delta: float) -> void:
	super._physics_process(delta)


func _on_died() -> void:
	queue_free()
