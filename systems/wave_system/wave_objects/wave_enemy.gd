class_name WaveEnemy
extends WaveObject


@export var enemy : PackedScene
@export var amount : int = 1
@export var path : int = 0
@export var delay : float = 0
var enemy_index = 0


func start(manager : WaveManager):
	for i in amount:
				var enemy = enemy.instantiate()
				if enemy.has_signal("freed"):
					enemy.freed.connect(manager.on_enemy_freed)
				manager.paths[path].add_child(enemy)
				manager.enemies_alive += 1
				await manager.get_tree().create_timer(delay, false).timeout
	
	object_finished.emit()
