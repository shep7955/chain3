class_name TileChar
extends TileObject



@export var Health := 1
@export var MaxHealth := 1




func _ready() -> void:
	DebugMenu.AddMonitor(self, "position")
	DebugMenu.AddMonitor(self, "velocity")
