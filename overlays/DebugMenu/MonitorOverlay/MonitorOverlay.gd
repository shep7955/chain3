extends MarginContainer


var BoundProperties = {}


const Property = preload("res://overlays/DebugMenu/MonitorProperty.gd")


func _process(delta: float) -> void:
	for p in BoundProperties:
		if p.UpdateValue():
			BoundProperties[p].text = str(p.object.name) + ": " + str(p.value)


func ToggleProperty(monProperty) -> void:
	if RemoveProperty(monProperty):
		return
	else:
		AddProperty(monProperty)
		


func AddProperty(monProperty) -> void:
	var label = Label.new()
	$VBoxContainer.add_child(label)
	BoundProperties[monProperty] = label


func RemoveProperty(monProperty) -> bool:
	for p in BoundProperties:
		if p.object == monProperty.object and p.property == monProperty.property:
			BoundProperties[p].queue_free()
			BoundProperties.erase(p)
			return true
	
	return false


func RemoveMonitor(object, property) -> void:
	var monProperty = Property.new(object, property, "")
	RemoveProperty(monProperty)


func ClearAllProperties():
	BoundProperties.clear()
	for i in $VBoxContainer.get_children():
		i.queue_free()
