extends Node2D


func ShowPickup(_item: Item) -> void:
	if _item:
		visible = true
	else:
		visible = false
