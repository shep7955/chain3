class_name TileItem
extends TileObject


@export var AssociatedItem : Item

var ObjectHeightOffset := 0.0


const ICON_BOB_SCALE = 0.1
const ICON_ADDITIONAL_OFFSET = 0.0


func _physics_process(delta: float) -> void:
	if ModelInstance != null:
		ModelInstance.position.z = ObjectHeight + ObjectHeightOffset + (sin(Globals.TileItemBobAccumulator) * ICON_BOB_SCALE)


func _on_item_pickup_trigger_body_entered(body: TilePlayer) -> void:
	ObjectHeightOffset = ICON_ADDITIONAL_OFFSET
	body.StandingOnItem.emit(AssociatedItem)


func _on_item_pickup_trigger_body_exited(body: TilePlayer) -> void:
	ObjectHeightOffset = 0.0
	body.StandingOnItem.emit(null)
