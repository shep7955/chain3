extends "res://effects/SpotShadow/SpotShadow.gd"


@export var BloodScale = 1.0


func _ready() -> void:
	DecalParent.scale = 0.001
	force_raycast_update()
	if !is_colliding():
		queue_free()


func _process(delta: float) -> void:
	DecalParent.scale += delta
