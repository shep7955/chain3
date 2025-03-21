extends Node3D


@export var WorldOffset := Vector2.ZERO

@onready var ObjectsRoot = $ActiveObjects
@onready var StoredObjects = $InactiveObjects


const SPHERE_TRANSFORM = preload("res://entities/SphereTransform/SphereTransform.tscn")


func _ready() -> void:	
	pass
	


func _physics_process(delta: float) -> void:
	
	for i in ObjectsRoot.get_children():
		i.CameraOffset = WorldOffset
	


func AddTileObject(newObject: TileObject) -> void:
	if newObject.ModelInstance != null:
		print("Object %s already has a physical form" % newObject.name)
		return
	
	var sphereTrans = SPHERE_TRANSFORM.instantiate()
	ObjectsRoot.add_child(sphereTrans)
	sphereTrans.BindTileObject(newObject)
	
	
