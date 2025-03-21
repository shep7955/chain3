extends Node


#Global System Settings
var WindowedModeScreenSize := Vector2i(640, 480)


#Debug features
const SHOW_DEBUG_ON_LAUNCH = true
const DEBUG_SCENES = {
	"ControllerInputTest": "res://scenes/ControllerInputTester/ControllerInputTester.tscn",
	"ExplosionTest": "res://scenes/ExplosionTest/ExplosionTest.tscn",
	"SmokeTest": "res://scenes/SmokeTest/SmokeTest.tscn",
	"TestScene": "res://scenes/TestScene/TestScene.tscn",
	"FreeCamTest": "res://scenes/FreeCamTest/FreeCamTest.tscn",
	"StateMachineTest": "res://scenes/StateManagerTest/StateManagerTest.tscn",
	"BarcodeScanTest": "res://scenes/BarcodeScanTest/BarcodeScanTest.tscn",
	"WorldScene": "res://scenes/WorldScene/WorldScene.tscn",
	"World3DRender": "res://entities/World3DRender/World3DRender.tscn",
	"NewSphereMovement": "res://scenes/NewSphereMovement/NewSphereMovement.tscn",
}
var CurrentScene = null




var PreviousMouseMode := -1


var PlayerObject = null

var TileItemBobAccumulator := 0.0


func _ready() -> void:
	#WindowedModeScreenSize = DisplayServer.window_get_size(0)
	pass
