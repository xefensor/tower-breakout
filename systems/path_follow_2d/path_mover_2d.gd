class_name PathMover2D
extends PathFollow2D


signal end_reached
signal freed


@export var free_on_end : bool = true
@export var progression_speed: float = 10
@export var is_moving : bool = true


func _ready() -> void:
	end_reached.connect(_on_end_reached)
	reset_physics_interpolation()
	

func _physics_process(delta: float) -> void:
	if is_moving:
		progress += progression_speed * delta

	if progress_ratio >= 1:
		end_reached.emit()


func _on_end_reached():
	if free_on_end:
		freed.emit()
		queue_free()
