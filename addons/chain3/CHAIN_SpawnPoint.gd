class_name CHAIN_SpawnPoint
extends Node

@export var DoorID : String;
signal _onSpawn;

func _ready() -> void:
	if (chain3.DoorID.to_lower() == DoorID.to_lower()):
		_onSpawn.emit();
