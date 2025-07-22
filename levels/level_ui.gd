extends CanvasLayer

@export var money = 0
@onready var enemy = $".."

func _ready() -> void:
	enemy.connect("died", _on_enemy_died)

func _on_enemy_died():
	money += 5
	$Label_money.text = str(money)
