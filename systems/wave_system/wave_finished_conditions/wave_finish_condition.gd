@abstract
class_name WaveFinishCondition
extends Resource


signal condition_met


@abstract
func setup(_wave: Wave) -> void


@abstract
func check() -> void
