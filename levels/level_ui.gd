class_name LevelUI
extends CanvasLayer

@export var money_label: Label
@onready var paddle = $"../Paddle"

func update_money_label(new_val: int):
	money_label.text = str(new_val)


func _on_upgrade_paddle_speed_pressed() -> void:
	if Level.instance.money >= 5:
		paddle._speed += 100
		Level.instance.money -= 5
