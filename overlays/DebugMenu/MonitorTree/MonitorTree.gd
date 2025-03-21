extends Tree


signal AddToMonitorOverlay(monProperty)


var treeRoot = null
var treeEntries = {}

const Property = preload("res://overlays/DebugMenu/MonitorProperty.gd")


func _ready() -> void:
	treeRoot = create_item()
	set_hide_root(true)


func _process(_delta: float) -> void:
	var deleted = []
	for t in treeEntries:
		if treeEntries[t].UpdateValue():
			var text = str(treeEntries[t].property) + ": " + str(treeEntries[t].value)
			t.set_text(0, text)
		else:
			deleted.append(t)
	
	for i in deleted:
		emit_signal("EntryDeleted", i)
		RemoveTreeEntry(i) #rework this to use RemoveMonitor


func AddMonitor(object, property, display = "") -> void:
	var monitorProperty = Property.new(object, property, display)
	
	var nodePath = object.get_path()
	assert(nodePath.is_absolute())
	
	var pathString = String(nodePath)
	var array = pathString.split("/", false, 1)
	AddMonitorProperty(monitorProperty, array[1], treeRoot)


func AddMonitorProperty(_property, _name, _parent):
	if _name.is_empty():
		var newEntry = create_item(_parent)
		newEntry.set_text(0, _property.object.name)
		treeEntries[newEntry] = _property
	else:
		var array = _name.split("/", false, 1)
		if array.size() > 0:
			array.push_back("")
			var siblings = _parent.get_children()
			for i in siblings:
				if i.get_text(0) == array[0]:
					AddMonitorProperty(_property, array[1], i)
					return
			
			#Entry isn't in the tree
			var newEntry = create_item(_parent)
			newEntry.set_text(0, array[0])
			newEntry.set_collapsed_recursive(true)
			AddMonitorProperty(_property, array[1], newEntry)


#TODO rework to deal with nested entries
func RemoveMonitor(object, property) -> void:
	
	var nodePath = object.get_path()
	assert(nodePath.is_absolute())
	
	var pathString = String(nodePath)
	var array = pathString.split("/", false, 1)
	RemoveMonitorProperty(property, array[1], treeRoot)
	
	
	#for t in treeEntries:
	#	var value = treeEntries[t]
	#	if value.object == object and value.property == property:
	#		RemoveTreeEntry(t)
	#		return


#gonna make a recursive function to handle all the nested entry removal
func RemoveMonitorProperty(_property, _name, _parent) -> bool:
	if _name.is_empty():
		for i in _parent.get_children():
			pass
	else:
		#move down the tree, but also call RemoveMonitorProperty recursively, check if there's any
		#children left, and remove this level from the tree if it's empty
		pass
		
		
	return true


func RemoveTreeEntry(t):
	if treeEntries.erase(t):
		var parent = t.get_parent()
		t.free()
		if parent.get_children() == null:
			parent.free()


func _on_item_activated() -> void:
	var selectedItem = get_selected()
	
	for i in treeEntries.keys():
		if i == selectedItem:
			emit_signal("AddToMonitorOverlay", treeEntries[i])
			return
