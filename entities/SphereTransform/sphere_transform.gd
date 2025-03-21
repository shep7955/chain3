class_name SphereTransform
extends Node3D

@export var TargetObject : TileObject

@export var ClampRange := true
@export var CameraOffset := Vector2.ZERO


const OFFSET_SCALE = Vector2(-0.0075, -0.005)
const MAX_RANGE = 90.0



func _ready() -> void:
	global_position = Vector3.ZERO
	
	DebugMenu.AddMonitor(self, "rotation")
	DebugMenu.AddMonitor(self, "CameraOffset")


func _physics_process(delta: float) -> void:
	if ClampRange:
		#print(rotation_degrees.x)
		if abs(rotation_degrees.x) > MAX_RANGE or abs(rotation_degrees.y) > MAX_RANGE:
			visible = false
		else:
			visible = true
	
	var offset = (CameraOffset - TargetObject.position.rotated(deg_to_rad(90.0))) * OFFSET_SCALE

	rotation.x = offset.y
	rotation.y = offset.x

	assert(rotation.x == offset.y)


func BindTileObject(newObject: TileObject) -> void:
	TargetObject = newObject
	
	#print("%s" % TargetObject.ObjectRotation)
	var model = TargetObject.ObjectModel.instantiate()
	add_child(model)
	TargetObject.ModelInstance = model
	
	model.position = Vector3(0, 0, TargetObject.ObjectHeight)
	assert(model.position == Vector3(0, 0, TargetObject.ObjectHeight))
	
	model.rotate_z(deg_to_rad(-90.0))
	model.rotate_y(deg_to_rad(TargetObject.ObjectRotation.y))
	model.rotate_x(deg_to_rad(TargetObject.ObjectRotation.x))

	TargetObject.Freeing.connect(Free)

	#PrepareChild(newObject.ObjectModel.instantiate(), newObject.ObjectRotation, newObject.ObjectHeight)


func PrepareChild(newChild: Node3D, rot: Vector2, height: float) -> void:
	var childPos = newChild.position
	newChild.position = Vector3(0, 0, height)
	assert(newChild.position == Vector3(0, 0, height))
	newChild.rotate_z(deg_to_rad(-90.0))
	newChild.rotate_y(deg_to_rad(rot.y))
	newChild.rotate_x(deg_to_rad(rot.x))


func Free() -> void:
	queue_free()
