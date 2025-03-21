extends MeshInstance3D


@export var Colour := Color.RED

var LineOffsets = [
	randf(),
	randf(),
	randf(),
	randf(),
	randf()
]

var accumulator := 0.0

@onready var Start = $Start
@onready var End = $End
@onready var Left = $End/Left
@onready var Right = $End/Right


func _process(delta: float) -> void:
	DrawEffect(delta)


func DrawEffect(_delta: float) -> void:
	accumulator += _delta
	if accumulator > TAU:
		accumulator -= TAU
	
	mesh.clear_surfaces()
	DrawBody()
	
	mesh.surface_begin(Mesh.PRIMITIVE_LINES)
	
	for i in range(LineOffsets.size()):
		mesh.surface_set_color(Color(Colour.r, Colour.g, Colour.b, 0.75 * (randf() * 0.25)))
		DrawScanLine(accumulator + LineOffsets[i])
	
	#Always draw lines on either side of the triangle
	mesh.surface_set_color(Color(Colour.r, Colour.g, Colour.b, 0.75))
	
	mesh.surface_add_vertex(Start.global_position)
	mesh.surface_add_vertex(Left.global_position)
	mesh.surface_add_vertex(Start.global_position)
	mesh.surface_add_vertex(Right.global_position)
	
	mesh.surface_end()
	

func DrawScanLine(offset) -> void:
	mesh.surface_add_vertex(Start.global_position)
	mesh.surface_add_vertex(Left.global_position + ((Right.global_position - Left.global_position) * (sin(2.0 * offset) + 1.0) / 2.0))


func DrawBody() -> void:
	var workColour = Colour
	
	mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLES)
	
	workColour.a = 0.3 + (randf() * 0.3)
	mesh.surface_set_color(workColour)
	mesh.surface_add_vertex(Start.global_position)
	
	workColour.a = 0.1 + (randf() * 0.1)
	mesh.surface_set_color(workColour)
	mesh.surface_add_vertex(Left.global_position)
	mesh.surface_add_vertex(Right.global_position)
	
	mesh.surface_end()

