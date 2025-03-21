extends BasicState



const CAMERA_ROT_SPEED = 5.0

func Enter(_msg := {}) -> void:
	pass
	

func Exit() -> void:
	pass
	

func Update(_delta: float) -> void:
	if Input.is_action_just_pressed("ResetCamera"):
		ChangeState("Reset", {
			"ResetAngle": Vector2(owner.TargetChar.CharMesh.rotation.y, -0.25)
		})
		return
	
	var CameraInput = Vector2(
		Input.get_action_strength("Camera_Right") - Input.get_action_strength("Camera_Left"),
		Input.get_action_strength("Camera_Down") - Input.get_action_strength("Camera_Up")
	)
	
	owner.Cam.position.z = lerp(owner.Cam.position.z, owner.Distance, _delta)
	
	owner.Rot.x += CameraInput.x * CAMERA_ROT_SPEED * _delta
	owner.Rot.y += CameraInput.y * CAMERA_ROT_SPEED * _delta
	
	owner.UpdateRotation()
