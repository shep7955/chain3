class_name TilePlayer
extends TileChar


signal NearbyObject(object: TileObject)
signal StandingOnItem(_item: Item)
signal PickedUpItem(_item: Item)


@export var AcceptInput := true


func _physics_process(delta: float) -> void:
	var MoveInput := Vector2.ZERO
	if AcceptInput:
		MoveInput = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
	
	velocity = MoveInput * 64.0
	
	move_and_slide()


func _on_object_loader_body_entered(body: TileObject) -> void:
	NearbyObject.emit(body)
