extends Node3D



@onready var up = $MeshInstance3D.global_transform.origin.normalized()
@onready var forward = $MeshInstance3D.global_transform.basis.y
@onready var right = forward.cross(up).normalized()


func _ready() -> void:
	DebugMenu.AddMonitor($MeshInstance3D, "global_position")


func _physics_process(delta: float) -> void:
	up = $MeshInstance3D.global_transform.origin.normalized()
	right = forward.cross(up).normalized()
	forward = up.cross(right).normalized()
	
	var move_input = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
	
	move_input = move_input.normalized()
	var direction = (forward * move_input.y) + (right * move_input.x)
	$MeshInstance3D.global_position += direction * 0.5
	$MeshInstance3D.global_position = $Sphere.global_position.direction_to($MeshInstance3D.global_position) * 7
	
