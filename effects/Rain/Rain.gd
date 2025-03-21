extends GPUParticles3D


func SetEmitting(value: bool) -> void:
	emitting = value
	$RainWaveSource.emitting = value
