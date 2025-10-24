class_name LevelUI
extends CanvasLayer


@export var money_label: Label
@export var health_label: Label


func update_money_label(new_val: int) -> void:
	money_label.text = str(new_val) + "$"


func update_health_lavel(new_val: int) -> void:
	health_label.text = str(new_val) + "HP"
