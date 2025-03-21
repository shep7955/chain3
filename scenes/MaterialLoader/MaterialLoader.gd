extends MeshInstance3D


signal MaterialsLoaded


@export var Materials : PackedStringArray

var MaterialsID := 0



func _process(delta):
	if MaterialsID > Materials.size() - 1:
		MaterialsLoaded.emit()
		queue_free()
	else:
		var newMaterial = load(Materials[MaterialsID])
		set_surface_override_material(0, newMaterial)
		MaterialsID += 1
