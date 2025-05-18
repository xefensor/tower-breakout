class_name Enemy
extends AnimatableBody2D


signal died()

@export var health: Health = Health.new()
@export var paddle_damage: int = 1
@export var explosion_audio_player: OneShotAudioPlayer
@export var explosion_sprite: OneShotAnimatedSprite2D

@onready var health_bar: TextureProgressBar = NodeUtils.get_child_by_class(self, TextureProgressBar)


func _init() -> void:
	tree_entered.connect(Level.instance.on_enemy_tree_entered)
	tree_exited.connect(Level.instance.on_enemy_tree_exited)
	

func _ready() -> void:
	reset_physics_interpolation()
	
	health.died.connect(_on_health_died)
	health.health_changed.connect(_on_health_changed)
	
	health_bar.value = 100 / health.max_health * health.current_health


func take_damage(amount: float) -> void:
	health.take_damage(amount)


func die() -> void:
	health.current_health = 0


func _on_health_died() -> void:
	died.emit()
	explosion_audio_player.one_shot_play(Level.instance)
	explosion_sprite.one_shot_play(Level.instance)
	queue_free()


func _on_health_changed(newhealth : int) -> void:
	health_bar.value = 100 /health.max_health * newhealth
