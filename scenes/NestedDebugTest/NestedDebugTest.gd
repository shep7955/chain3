extends Node3D


const nodes = preload("res://scenes/NestedDebugTest/NestedNodes.tscn")


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		add_child(nodes.instantiate())
	if Input.is_action_just_pressed("ui_cancel"):
		var children = get_children()
		if children.size() > 0:
			children[0].queue_free()
