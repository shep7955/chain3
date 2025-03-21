class_name CameraFocus
extends Node3D



@onready var Target = get_parent()


func ChangeState(NewState: String) -> bool:
	return $StateMachine.ChangeState(NewState)
