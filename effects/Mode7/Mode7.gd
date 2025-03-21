extends Sprite2D


var Mode7Transform: Transform3D = Transform3D.IDENTITY

var Pos := Vector2.ZERO
var Rot := 0.0


@onready var Mat : ShaderMaterial = material


func _ready() -> void:
	SetDepth(Vector2(0, 0.85))
	UpdateShaderTransform()


func _physics_process(delta: float) -> void:
	UpdateTransform()
	UpdateShaderTransform()


func SetDepth(newDepth: Vector2) -> void:
	Mat.set_shader_parameter("DEPTH", newDepth)


func UpdateTransform() -> void:
	Mode7Transform.origin.x = Pos.x
	Mode7Transform.origin.y = Pos.y
	
	Mode7Transform.basis.x[0] = cos(Rot)
	Mode7Transform.basis.x[1] = -sin(Rot)
	Mode7Transform.basis.y[0] = sin(Rot)
	Mode7Transform.basis.y[1] = cos(Rot)


func UpdateShaderTransform() -> void:
	Mat.set_shader_parameter("TRANSFORM", Mode7Transform)
