extends Node3D


const ExplosionEffect = preload("res://effects/ExplosionPlane/ExplosionPlane.tscn")
const ExplosionSphereEffect = preload("res://effects/ExplosionSphere/ExplosionSphere.tscn")



func _process(_delta: float) -> void:
	$Node3D.rotate_y(_delta)
	
	if Input.is_key_pressed(KEY_SPACE):
		if randi() % 10 > 5:
			SpawnSphereExplosion()
		else:
			var explosion = ExplosionEffect.instantiate()
			explosion.Lifetime = randf() * 1.5 + 0.25
			#explosion.MaxSize = randf() * 3.0 + 1.0
			add_child(explosion)
			explosion.position = Vector3(randf() * 2.0 - 1.0, randf() * 2.0 - 1.0, randf() * 2.0 - 1.0)
		


func SpawnSphereExplosion() -> void:
	var explosion = ExplosionSphereEffect.instantiate()
	explosion.Lifespan = randf() + 1.0
	explosion.MaxSize = explosion.Lifespan + (randf() * 0.5)
	add_child(explosion)
	explosion.position = Vector3(randf() * 2.0 - 1.0, randf() * 2.0 - 1.0, randf() * 2.0 - 1.0)
