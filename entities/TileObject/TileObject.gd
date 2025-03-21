class_name TileObject
extends CharacterBody2D


signal Freeing


@export var ObjectModel : PackedScene
@export var ModelInstance : Node3D = null
@export var ObjectHeight := 5.5
@export var ObjectRotation : Vector2


func GetRotation() -> float:
	return rotation
