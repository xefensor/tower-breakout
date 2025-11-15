class_name WaveEnemy
extends WaveObject


@export var enemy_resource: EnemyResource
@export var amount: int = 1
@export var path: int = 0
@export var delay: float = 0

var enemy_index: int = 0


func start() -> void:
	for i in amount:
		var enemy_inst: EnemyMover2D = enemy_resource.scene.instantiate()
		enemy_inst.progression_speed = enemy_resource.speed
		
		var enemy: Enemy = NodeUtils.get_child_by_class(enemy_inst, Enemy)
		enemy.health.current_health = enemy_resource.health
		enemy.health.max_health = enemy_resource.health
		enemy.paddle_damage = enemy_resource.paddle_damage
		enemy.money = enemy_resource.money
		enemy.powers = enemy_resource.powers
		
		Level.instance.paths[path].add_child(enemy_inst)
		await Level.instance.get_tree().create_timer(delay, false).timeout
	
	object_finished.emit()
