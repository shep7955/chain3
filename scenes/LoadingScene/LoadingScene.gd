extends Node2D


@export var NextScene: PackedScene

var LoadingTime := 0.0

@onready var LoadIcon = $LoadingIcons/NowLoading


func _ready() -> void:
	#ProjectSettings.load_resource_pack("res://graphics.pck")
	pass


func _process(delta: float) -> void:
	LoadIcon.modulate.a = clamp(0.4 + abs(sin(LoadingTime)) * 0.6, 0.0, 1.0)
	LoadingTime += delta


func ChangeToScene() -> void:
	if NextScene.is_empty():
		print("LoadingScene: Failed to load: no scene")
		return
	get_tree().change_scene_to_packed(NextScene)
	

