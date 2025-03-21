@tool
extends Node



@export var FogColour := Color.WHITE
@export var FogStart := 1.0
@export var FogEnd := 100.0

var colourTween = null
var startTween = null
var endTween = null


func _ready():
	SetFogParameters()
	
	DebugMenu.AddMonitor(self, "FogColour")
	DebugMenu.AddMonitor(self, "FogStart")
	DebugMenu.AddMonitor(self, "FogEnd")


func _process(_delta):
	SetFogParameters()


func SetFogParameters() -> void:
	RenderingServer.global_shader_parameter_set("FogColour", FogColour)
	RenderingServer.global_shader_parameter_set("FogStart", FogStart)
	RenderingServer.global_shader_parameter_set("FogEnd", FogEnd)


func FogTransition(newColour: Color, newStart: float, newEnd: float, timeInSeconds: float) -> void:
	if colourTween != null:
		colourTween.kill()
	colourTween = create_tween()
	colourTween.tween_property(self, "FogColour", newColour, timeInSeconds)
	if startTween != null:
		startTween.kill()
	startTween = create_tween()
	startTween.tween_property(self, "FogStart", newStart, timeInSeconds)
	if endTween != null:
		endTween.kill()
	endTween = create_tween()
	endTween.tween_property(self, "FogEnd", newEnd, timeInSeconds)
