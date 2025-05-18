class_name Attack
extends Resource


var damage: int


func apply_to(target: Node) -> void:
	if target.has_method("apply_damage"):
		target.apply_damage(damage)
