class_name Enemy
extends AnimatableBody2D


signal died()

@export var health: Health = Health.new()
@export var paddle_damage: int = 1
@export var money: int = 5
@export var power_drop_chance: int = 10
@export var powers: Powers
@export var explosion_audio_player: OneShotAudioPlayer
@export var explosion_sprite: OneShotAnimatedSprite2D
@export var hit_color: Color = Color(1, 0.3, 0.3) # červený efekt
@export var hit_duration: float = 0.1

var tween : Tween

@onready var health_bar: TextureProgressBar = NodeUtils.get_child_by_class(self, TextureProgressBar)
@onready var sprite: CanvasItem = $Sprite2D # uprav podle toho, co používáš


func _init() -> void:
	tree_entered.connect(Level.instance.on_enemy_tree_entered)
	tree_exited.connect(Level.instance.on_enemy_tree_exited)
	

func _ready() -> void:
	reset_physics_interpolation()
	
	health.died.connect(_on_health_died)
	health.health_changed.connect(_on_health_changed)
	
	health_bar.value = 100.0 / health.max_health * health.current_health


func take_damage(amount: int) -> void:
	health.take_damage(amount)
	_play_hit_effect()


func _play_hit_effect() -> void:
	tween = create_tween()
	var original_color := sprite.modulate
	sprite.modulate = hit_color
	tween.tween_property(sprite, "modulate", original_color, hit_duration)


func die() -> void:
	health.current_health = 0


func _on_health_died() -> void:
	died.emit()
	explosion_audio_player.one_shot_play(Level.instance)
	explosion_sprite.one_shot_play(Level.instance)
	Level.instance.money += 5
	
	var power: Power = powers.choose_power(powers.powers)
	if power:
		var scene: PackedScene = preload("res://power_ups/falling_power.tscn")
		var inst: FallingPower = scene.instantiate()
		inst.power = power
		inst.global_position = global_position
		Level.instance.add_child(inst)
	
	queue_free()


func _on_health_changed(newhealth : int) -> void:
	health_bar.value = 100.0 / health.max_health * newhealth
