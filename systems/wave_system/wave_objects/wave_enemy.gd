class_name WaveEnemy
extends WaveObject


@export var enemy: PackedScene
@export var amount: int = 1
@export var path: int = 0
@export var delay: float = 0

var enemy_index = 0


func start() -> void:
	for i in amount:
		var enemy = enemy.instantiate()
		Level.instance.paths[path].add_child(enemy)
		await Level.instance.get_tree().create_timer(delay, false).timeout
	
	object_finished.emit()
