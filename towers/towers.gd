class_name Towers
extends Node


@export var max_towers: int = 5
@export var towers: Array[Tower]

@onready var placeable_area := NodeUtils.get_child_by_class(self, Area2D)


func _ready() -> void:
	pass


func start_towers() -> void:
	for tower in towers:
		tower.start()
		
		
func stop_towers() -> void:
	for tower in towers:
		tower.stop()


func rotate_tower(tower: Tower, rotation: float) -> void:
	tower.rotation = clamp(rotation, -PI, 0)


func add_tower() -> void:
	var tower_load: PackedScene = preload("res://towers/tower.tscn")
	var tower_inst: Tower = tower_load.instantiate()
	pass
