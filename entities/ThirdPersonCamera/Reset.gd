extends BasicState



var ResetAngle := Vector2.ZERO
var ReturnState := "Manual"


const MIN_ROT_VALUE = 0.01
const ROT_LERP_SPEED = 20.0


func Enter(_msg := {}) -> void:
	#ResetAngle = Vector2(owner.rotation.y, -0.25)
	
	if _msg.has("ResetAngle"):
		ResetAngle = _msg["ResetAngle"]
	if _msg.has("ReturnState"):
		ReturnState = _msg["ReturnState"]
	

func Exit() -> void:
	pass
	

func Update(_delta: float) -> void:
	if owner.Rot.distance_to(ResetAngle) <= MIN_ROT_VALUE:
		owner.Rot = ResetAngle
		ChangeState(ReturnState)
		return
	
	owner.Cam.position.z = lerp(owner.Cam.position.z, owner.Distance, _delta)
	
	owner.Rot = lerp(owner.Rot, ResetAngle, ROT_LERP_SPEED * _delta)
	owner.UpdateRotation()
