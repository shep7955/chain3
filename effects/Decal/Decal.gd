extends MeshInstance3D


@export var VerticalOffset := 0.0

var CollisionPoint := Vector3.ZERO
var CollisionNormal := Vector3.ZERO


func UpdateWithRaycast(_ray: RayCast3D) -> void:
	if !_ray.is_colliding():
		visible = false
	else:
		visible = true
		CollisionPoint = _ray.get_collision_point()
		CollisionNormal = _ray.get_collision_normal()
		
		var _scale = scale
		global_transform = AlignWithY(global_transform, CollisionNormal)
		scale = _scale
		global_position = CollisionPoint + (global_transform.basis.y * VerticalOffset)


func AlignWithY(newTransform: Transform3D, newY: Vector3) -> Transform3D:
	newTransform.basis.y = newY
	newTransform.basis.x = -newTransform.basis.z.cross(newY)
	newTransform.basis = newTransform.basis.orthonormalized()
	return newTransform
