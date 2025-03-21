extends Node2D


func _ready() -> void:
	#Load global settings (volume settings, etc) then go to loading scene
	Input.add_joy_mapping("030000006f0e0000ef02000007640000,PDP Kinetic Xbox Series Wired Controller,a:b0,b:b1,back:b6,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,guide:b8,leftshoulder:b4,leftstick:b9,lefttrigger:a2,leftx:a0,lefty:a1,rightshoulder:b5,rightstick:b10,righttrigger:a5,rightx:a3,righty:a4,start:b7,x:b2,y:b3,platform:Linux,", true)
	
	Globals.WindowedModeScreenSize = DisplayServer.window_get_size(0)
	
	
	get_tree().change_scene_to_file("res://scenes/GorillaApology/GorillaApology.tscn")
