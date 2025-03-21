extends Area3D


signal FogTransition(colour, start, end, time)
signal FogTriggerActivated


@export var TransitionSpeed := 1.0
@export var FogColour := Color.WHITE
@export var FogStart := 1.0
@export var FogEnd := 100.0


var OriginalFogColour := Color.WHITE
var OriginalFogStart := 1.0
var OriginalFogEnd := 100.0


func _on_body_entered(_body: Node3D) -> void:
	print("FogTriggerHit")
	
	FogTransition.emit(FogColour, FogStart, FogEnd, TransitionSpeed)
	FogTriggerActivated.emit()
	Toggle()


func Toggle() -> void:
	set_deferred("monitoring", !monitoring)
