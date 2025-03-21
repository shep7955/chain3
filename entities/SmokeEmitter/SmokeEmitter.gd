extends Node3D


signal EmissionComplete


@export var Smoke : PackedScene
@export var EmissionLifetime := 1.0
@export var EmissionRate := 0.1
@export var EmissionSize := 1.0


var Accumulator := 0.0


func _process(delta):
	pass
