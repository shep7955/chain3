extends ColorRect


@onready var Mat : ShaderMaterial = material

func SetViewportTexture(newTex: Texture) -> void:
	Mat.set_shader_parameter("albedo_tex", newTex)


func SetAlphaLevel(newLevel: float) -> void:
	Mat.set_shader_parameter("alpha", newLevel)
