extends ColorRect



const INTENSITY_MAX = 2.5
const OPACITY_MAX = 0.25


func SetVignetteLevel(level: float) -> void:
	material.set_shader_param("vignette_intensity", clamp(INTENSITY_MAX * level, 0.0, INTENSITY_MAX))
	#material.set_shader_param("vignette_opacity", clamp(OPACITY_MAX * level, 0.0, OPACITY_MAX))
