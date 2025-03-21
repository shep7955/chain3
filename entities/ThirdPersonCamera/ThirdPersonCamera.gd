extends Node3D


@export var Focus : CameraFocus


var Rot := Vector2(0.0, -0.25)
var Distance := 5.0


const VERTICAL_CLAMP = 1.5

@onready var Cam = $Camera3D
@onready var StateMachine = $StateMachine


func _ready():
	DebugMenu.AddMonitor(self, "Rot")
	
	#StateMachine.InitialiseStateMachine()


func GetCameraBasis() -> Basis:
	return Cam.get_camera_transform().basis


func GetCameraDistance() -> float:
	return Cam.position.z


func Activate() -> void:
	Cam.current = true
	Globals.CurrentCamera = Cam


func UpdateRotation() -> void:
	transform.basis = Basis()
	Rot.y = clamp(Rot.y, -VERTICAL_CLAMP, VERTICAL_CLAMP)
	rotate_object_local(Vector3(0, 1, 0), Rot.x)
	rotate_object_local(Vector3(1, 0, 0), Rot.y)
