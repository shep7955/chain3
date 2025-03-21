@tool
extends Sprite3D


@export var PulseRate := 1.0


var PulseAccumulator := 0.0


func _process(delta: float) -> void:
	PulseAccumulator += delta
	if PulseAccumulator > PulseRate:
		PulseAccumulator -= PulseRate
	
	
	modulate.a = sin((PulseAccumulator / PulseRate) * PI)
