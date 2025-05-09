class_name PathMover2D
extends PathFollow2D


signal end_reached


@export var free_on_end: bool = true
@export var progression_speed: float = 10
@export var moving: bool = true


func _ready() -> void:
	end_reached.connect(_on_end_reached)
	reset_physics_interpolation()
	

func _physics_process(delta: float) -> void:
	if moving:
		progress += progression_speed * delta

	if progress_ratio >= 1:
		end_reached.emit()


func _on_end_reached() -> void:
	if free_on_end:
		queue_free()
