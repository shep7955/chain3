extends Node3D



func _process(delta: float) -> void:
	$CameraPivot.rotate_y(delta)
