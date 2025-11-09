class_name Game
extends Node


static var balls: Dictionary[StringName, BallRegistry]
static var effects: Dictionary[StringName, EffectRegistry]


func _init() -> void:
	var reg: Registry = load("res://systems/registry/registry.tres")
	balls = reg.balls
	effects = reg.effects
