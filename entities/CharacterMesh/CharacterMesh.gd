class_name CharacterMesh
extends Node3D


@export var MeshTurningSpeed := 6.0
@export var MinTargetLength := 0.01


func _ready() -> void:
	DebugMenu.AddMonitor(self, "rotation_degrees")


func LerpMeshOrientation(target: Vector3, delta: float, ignoreY := true) -> void:
	assert(!is_nan(target.x)) 
	assert(!is_nan(target.y))
	assert(!is_nan(target.z))
	
	if target.length() <= MinTargetLength:
		return
	
	if ignoreY:
		target *= Vector3(1, 0, 1)
	
	var lerpTo = atan2(-target.x, -target.z) #-rotation.y
	
	rotation.y = lerp_angle(rotation.y, lerpTo, MeshTurningSpeed * delta)


func SetOrientation(newOrientation: Vector3) -> void:
	global_transform.basis.from_euler(newOrientation)


func GetForwardVector() -> Vector3:
	return -global_transform.basis.z


func LookAt(target: Vector3) -> void:
	look_at((target * Vector3(1, 0, 1)) + (global_position * Vector3(0, 1, 0)))


func AlignToY(newY: Vector3) -> void:
	global_transform.basis.y = newY
	global_transform.basis.x = -global_transform.basis.z.cross(global_transform.basis.y)
	global_transform.basis = global_transform.basis.orthonormalized()

