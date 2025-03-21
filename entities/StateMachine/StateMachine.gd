class_name StateMachine
extends Node


signal StateChange(state_name)


@export var InitialState := NodePath()
@onready var CurrentState: BasicState = get_node(InitialState)


func _ready() -> void:
	await(owner.ready)
	
	for i in get_children():
		i.ParentStateMachine = self
	
	CurrentState.Enter()


func _process(delta: float) -> void:
	CurrentState.Update(delta)


func ChangeState(newState : String, msg := {}) -> bool:
	CurrentState.Exit()
	if !get_node(newState):
		return false
	CurrentState = get_node(newState)
	CurrentState.Enter(msg)
	emit_signal("StateChange", CurrentState.name)
	return true
	

func ButtonStateChanged(button: String, state) -> void:
	CurrentState.ButtonStateChanged(button, state)
