extends RayCast3D


@export var Activator: Node3D


var HoveredInteractable = null
var WaitAccumulator := 0.0 #use after free bug due to double click event, but might not exist in 4.0?

const WAIT_TIME = 0.005


func _process(delta: float) -> void:
	if WaitAccumulator < WAIT_TIME:
		WaitAccumulator += delta
		return
	
	if enabled:
		force_raycast_update()
		if is_colliding():
			HoveredInteractable = get_collider()
		else:
			HoveredInteractable = null
		


func Interact() -> void:
	if enabled:
		if GetInteractable():
			WaitAccumulator = 0.0
			HoveredInteractable.Interact(Activator)


func GetInteractable() -> Interactable:
	if is_instance_valid(HoveredInteractable):
		return HoveredInteractable
	
	return null


func GetInteractableName() -> String:
	if GetInteractable():
		return HoveredInteractable.InteractableName
	
	return ""


func GetInteractableDescription() -> String:
	if GetInteractable():
		return HoveredInteractable.InteractableDescription
	
	return ""
