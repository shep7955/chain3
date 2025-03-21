class_name InputController
extends Node


signal ButtonStateChanged(button: String, state)


enum {
	BUTTON_JUST_PRESSED,
	BUTTON_PRESSED,
	BUTTON_RELEASED,
} 


var AnalogueLeft := Vector2.ZERO
var AnalogueRight := Vector2.ZERO

var ButtonState := {}


func _input(event: InputEvent) -> void:
	pass


func _physics_process(delta: float) -> void:
	pass


func InitButtonState(newButtons : PackedStringArray) -> void:
	for i in newButtons:
		ButtonState[i] = BUTTON_RELEASED
