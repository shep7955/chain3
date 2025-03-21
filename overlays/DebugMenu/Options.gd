extends Control



@onready var ChkFullscreen = $ChkFullscreen
@onready var ChkShowVectors = $ChkShowVectors
@onready var BtnFPS = $BtnFPS
@onready var OptVSync = $LblVSync/OptVSync
@onready var VectorOverlay = $"../../../VectorDraw"


func _ready() -> void:
	BtnFPS.text = "FPS: " + str(Engine.physics_ticks_per_second)
	OptVSync.selected = DisplayServer.window_get_vsync_mode()
	ChkFullscreen.button_pressed = DisplayServer.window_get_mode() >= 3


func _on_chk_fullscreen_toggled(toggled_on):
	var mode = DisplayServer.WINDOW_MODE_FULLSCREEN
	if toggled_on == false:
		mode = DisplayServer.WINDOW_MODE_WINDOWED
		DisplayServer.window_set_size(Globals.WindowedModeScreenSize, 0)
	
	var windows : PackedInt32Array = DisplayServer.get_window_list()
	if windows.size() == 1:
		DisplayServer.window_set_mode(mode, windows[0])
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, toggled_on, windows[0])
		#print(DisplayServer.screen_get_size(0))
	else:
		printerr("Unimplemented: fullscreen with multiple windows")


func _on_chk_show_vectors_toggled(toggled_on):
	VectorOverlay.visible = toggled_on


func _on_btn_fps_pressed():
	var currentFPS = Engine.physics_ticks_per_second
	if currentFPS == 240:
		currentFPS = 15
	else:
		if currentFPS == 15:
			currentFPS += 15
		else:
			currentFPS += 30
	
	BtnFPS.text = "FPS: " + str(currentFPS)
	Engine.physics_ticks_per_second = currentFPS


func _on_opt_v_sync_item_selected(index):
	DisplayServer.window_set_vsync_mode(index)


func _on_chk_show_debug_toggled(toggled_on: bool, groupName: String) -> void:
	var nodes = get_tree().get_nodes_in_group(groupName)
	for i in nodes:
		i.visible = toggled_on
