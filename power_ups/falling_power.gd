class_name FallingPower
extends Area2D

@export var fall_speed: float = 40
@onready var screen_notifier: VisibleOnScreenNotifier2D = VisibleOnScreenNotifier2D.new()

var effect

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	screen_notifier.screen_exited.connect(_on_visible_on_screen_notifier_2d_screen_exited)


func _physics_process(delta: float) -> void:
	position.y += fall_speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body is Paddle:
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
