extends Node


#To be compiled in instead of the actual debugmenu for release builds
#needs to recreate the entire outward facing functions to work
#also needs to be added manually because it turns out that it overwrites the real
#one if it has the same name in the autoload


func SetVisibility(_visibility : bool) -> void:
	pass


func AddMonitor(object, property, display = "") -> void:
	pass


func RemoveMonitor(object, property) -> void:
	pass
