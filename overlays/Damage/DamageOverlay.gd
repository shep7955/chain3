extends Control


var MinBloodLevel := 0.0
var CurBloodOpacity := 0.0


@onready var BloodLayer = $BloodLayer
@onready var Splatters = $Splatters

const SPLATTER_OBJ = preload("res://overlays/Damage/DamageSplatter/DamageSplatter.tscn")
const DAMAGE_PERCENT_MODIFIER = 0.75
const DAMAGE_ALPHA_MODIFIER = 2.75
const CURRENT_OPACITY_LERP_MODIFIER = 2.0


func _ready() -> void:
	DebugMenu.AddMonitor(self, "MinBloodLevel")
	DebugMenu.AddMonitor(self, "CurBloodOpacity")


func _process(delta: float) -> void:
	CurBloodOpacity = lerp(CurBloodOpacity, MinBloodLevel, delta / CURRENT_OPACITY_LERP_MODIFIER)
	BloodLayer.color.a = clamp(CurBloodOpacity, 0.0, 1.0)


func Reset() -> void:
	BloodLayer.color.a = 0.0
	MinBloodLevel = 0.0
	CurBloodOpacity = 0.0
	
	for i in Splatters.get_children():
		i.queue_free()
