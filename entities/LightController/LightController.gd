@tool
extends Node3D


@export var AmbientColour := Color.BLACK
@export var DirLightColour := Color.WHITE

var LastPosition := Vector3.ZERO
var LastDirColour := Color.WHITE
var LastAmbient := Color.WHITE


func _ready() -> void:
	SetVertexLighting()


func _process(_delta: float) -> void:
	if global_position != LastPosition or DirLightColour != LastDirColour or AmbientColour != LastAmbient:
		SetVertexLighting()
		LastPosition = global_position
		LastDirColour = DirLightColour
		LastAmbient = AmbientColour
		
	


func SetVertexLighting() -> void:
	RenderingServer.global_shader_parameter_set("LightAmbient", AmbientColour)
	RenderingServer.global_shader_parameter_set("LightColour", DirLightColour)
	RenderingServer.global_shader_parameter_set("LightDir", global_position.normalized())
