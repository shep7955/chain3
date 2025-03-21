extends Control


signal TextComplete


@export var Text : String
@export var AdvanceText := true
@export var AdvanceTextSpeed := 0.1
@export var TextBoopStream : AudioStream = null

var TextAdvanceAccumulator := 0.0

@onready var RTL = $RichTextLabel


func _ready() -> void:
	RTL.parse_bbcode(Text)
	if TextBoopStream:
		$TextBoop.stream = TextBoopStream


func _process(delta: float) -> void:
	TextAdvanceAccumulator += delta
	if TextAdvanceAccumulator > AdvanceTextSpeed:
		pass
