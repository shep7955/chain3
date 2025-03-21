extends Control


class DebugVector:
	var object
	var property
	var scale
	var width
	var colour
	
	func _init(_object, _property, _scale, _width, _colour) -> void:
		object = _object
		property = _property
		scale = _scale
		width = _width
		colour = _colour
		
	func Draw(node, camera):
		var start = camera.unproject_position(object.global_position)
		var end = camera.unproject_position(object.global_position + object.get(property) * scale)
		node.draw_line(start, end, colour, width)
		node.DrawTriangle(end, start.direction_to(end), width * 2, colour)


var Vectors = []


func _process(_delta) -> void:
	if visible:
		queue_redraw()


func _draw() -> void:
	var camera = get_viewport().get_camera_3d()
	for i in Vectors:
		i.Draw(self, camera)


func DrawTriangle(_pos, _dir, _size, _colour) -> void:
	var a : Vector2 = _pos + _dir * size
	var b : Vector2 = _pos + _dir.rotated(2 * PI / 3) * _size
	var c : Vector2 = _pos + _dir.rotated(4 * PI / 3) * _size
	var points := PackedVector2Array([a, b, c])
	draw_polygon(points, PackedColorArray([_colour]))


func AddVector(_object, _property, _scale, _width, _colour):
	Vectors.append(DebugVector.new(_object, _property, _scale, _width, _colour))
	
	


func RemoveVector(_object, _property):
	for i in Vectors:
		if (i.object == _object) and (i.property == _property):
			Vectors.erase(i)
			return
