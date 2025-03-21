class_name Interactable
extends Area3D



signal Interaction


@export var InteractableName := "Interactable"
@export var InteractableDescription := "InteractableDescription"


func Interact(_activator) -> void:
	emit_signal("Interaction", _activator)
