extends Node3D


@export var MaxSize := 1.0
@export var Lifespan := 1.0
@export var FadeStartTime := 0.5

@onready var CurrentLife := Lifespan
@onready var Mat : ShaderMaterial = $ExplosionSphereMesh.get_surface_override_material(0)

const MIN_SIZE = 0.001


func _ready() -> void:
	scale = Vector3.ONE * MIN_SIZE
	#scale = Vector3.ONE


func _process(delta: float) -> void:
	if CurrentLife <= 0.0:
		queue_free()
	elif CurrentLife < FadeStartTime:
		Fadeout(CurrentLife - delta)
	
	CurrentLife -= delta
	
	scale = Vector3.ONE * clamp(MaxSize * (1.0 - (CurrentLife / Lifespan)), MIN_SIZE, MaxSize)


func Fadeout(alpha) -> void:
	Mat.set_shader_parameter("shader_parameter/modulate_color", Color.WHITE * alpha)
