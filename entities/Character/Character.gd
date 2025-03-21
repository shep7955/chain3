class_name Character
extends CharacterBody3D


signal HealthChanged(Percentage: float)
signal HealthEmpty

@export var Health := 1
@export var MaxHealth := 1

var Speed := 0.0

@onready var WorldCollision : CollisionShape3D = $WorldCollision
@onready var CharMesh : CharacterMesh = $CharacterMesh


func _ready() -> void:
	DebugMenu.AddMonitor(self, "global_position")
	DebugMenu.AddMonitor(self, "velocity")
	DebugMenu.AddMonitor(self, "Speed")
	DebugMenu.AddMonitor(self, "Health")
	DebugMenu.AddMonitor(self, "MaxHealth")
	
	#This is to fix problems caused by rotating the model in the editor
	#as the controls for the character assume an axis aligned node
	var newRotation = rotation_degrees
	global_transform.basis = Basis.IDENTITY
	CharMesh.rotation_degrees = newRotation


func ReceiveDamage(damage: int) -> void:
	if Health <= 0:
		return
	
	if Health - damage <= 0:
		emit_signal("HealthEmpty")
	else:
		emit_signal("HealthChanged", float(damage) / float(MaxHealth))
	
	Health = clamp(Health - damage, 0, MaxHealth)


func SetVelocity(newVel: Vector3) -> void:
	velocity = newVel
	Speed = newVel.length()


func Move(newVelocity: Vector3) -> void:
	move_and_slide()
	Speed = velocity.length()
