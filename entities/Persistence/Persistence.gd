extends Node


@export var Enabled := true

var PersistValues = []

#remember to check this if having trouble with saving: godot adds @ symbols to names, gotta free()
@onready var OwnerName := String(owner.get_path())



func BindPersistValue(property) -> void:
	PersistValues.append(property)
	
	
func LoadPersistenceData() -> bool:
	if !Enabled:
		return false
	
	var saveData = SaveManager.GetNodeData(OwnerName)
	if saveData == null:
		return false
	
	for i in PersistValues:
		if saveData.has(i):
			var value = saveData[i]
			#var nodeArray = owner.get_node_and_resource(i)
			#Theoretically this is how we should be getting the values, but it 
			#returns null ATM, figure out how to do it right because code below
			#doesn't work with child nodes (by design)
			owner.set_indexed(i, value)
	
	return true
