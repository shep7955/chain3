extends MeshInstance3D



@export var Lifetime := 0.75
@export var MaxSize := 1.0

var CurrentLife := 0.0

var CurrentFrame := 1

const Frames = [
	#Vector2(0.0, 0.0),
	Vector2(0.25, 0.0),
	Vector2(0.5, 0.0),
	Vector2(0.75, 0.0),
	Vector2(0.0, 0.25),
	Vector2(0.25, 0.25),
	Vector2(0.5, 0.25),
	Vector2(0.75, 0.25),
	Vector2(0.0, 0.5),
	Vector2(0.25, 0.5),
	Vector2(0.5, 0.5),
	Vector2(0.75, 0.5),
	Vector2(0.0, 0.75),
	Vector2(0.25, 0.75),
	Vector2(0.5, 0.75),
	Vector2(0.75, 0.75),
]

@onready var mat : Material = get_surface_override_material(0)


func _process(delta: float) -> void:
	mat.set_shader_parameter("uv_offset", Frames[CurrentFrame])
	var FrameLife = Lifetime / Frames.size()
	
	CurrentLife += delta
	if CurrentLife > FrameLife:
		CurrentLife -= FrameLife
		CurrentFrame += 1
		if CurrentFrame >= Frames.size():
			CurrentFrame -= 1
			queue_free()
