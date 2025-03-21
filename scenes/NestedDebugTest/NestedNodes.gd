extends Node3D



func _ready() -> void:
	DebugMenu.AddMonitor($Second/Third, "global_position")




func _on_tree_exiting() -> void:
	DebugMenu.RemoveMonitor($Second/Third, "global_position")
	pass
