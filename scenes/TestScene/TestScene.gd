extends Node3D


var accumulator := 0.0


@onready var cube = $MeshInstance3D


func _ready():
	DebugMenu.AddVector(cube, "global_position", 1.0, 3.0, Color.RED)
	
	
func _process(delta: float) -> void:
	accumulator += delta
	cube.global_position.y = sin(accumulator)
	#cube.rotate_y(accumulator)
	
	if Input.is_action_just_pressed("ui_home"):
		DebugMenu.RemoveVector(cube, "global_position")
