extends CanvasLayer



@onready var DebugMaster = $DebugMaster
@onready var SceneList = $DebugMaster/TabContainer/Scenes/ItmLstScenes
@onready var MonitorTree = $DebugMaster/TabContainer/Monitors/MonitorTree
@onready var MonitorOverlay = $MonitorOverlay
@onready var VectorDraw = $VectorDraw


func _ready() -> void:
	if Globals.SHOW_DEBUG_ON_LAUNCH:
		if OS.is_debug_build():
			SetVisibility(true)
	else:
		SetVisibility(false)
	
	for i in Globals.DEBUG_SCENES.keys():
		SceneList.add_item(i)


func _input(event):
	if event.is_action_pressed("DEBUG_Toggle") and OS.is_debug_build():
		SetVisibility(!DebugMaster.visible)


func SetVisibility(_visibility : bool) -> void:
	DebugMaster.visible = _visibility
	get_tree().paused = _visibility


func AddMonitor(object, property, display = "") -> void:
	MonitorTree.AddMonitor(object, property, display)


func RemoveMonitor(object, property) -> void:
	MonitorTree.RemoveMonitor(object, property)
	MonitorOverlay.RemoveMonitor(object, property)
	#TODO
	#MonitorOverlay.RemoveMonitor()


func AddVector(object, property, scale, width, colour) -> void:
	VectorDraw.AddVector(object, property, scale, width, colour)


func RemoveVector(object, property) -> void:
	VectorDraw.RemoveVector(object, property)


func _on_itm_lst_scenes_item_activated(index: int) -> void:
	Globals.CurrentScene = Globals.DEBUG_SCENES[SceneList.get_item_text(index)]
	SetVisibility(false)
	var _error = get_tree().change_scene_to_file(Globals.CurrentScene)


func _on_chk_show_monitors_toggled(button_pressed: bool) -> void:
	MonitorOverlay.visible = button_pressed

