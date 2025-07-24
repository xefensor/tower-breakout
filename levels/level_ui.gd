class_name LevelUI
extends CanvasLayer

@export var money_label: Label

func update_money_label(new_val: int):
	money_label.text = str(new_val)
