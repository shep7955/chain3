extends MeshInstance3D

@onready var Mat : ShaderMaterial = get_surface_override_material(0)

func _ready() -> void:
	pass
	#Mat.set_shader_parameter("WorldPosition", global_position)
