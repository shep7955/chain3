extends Sprite2D


var SplatterDecals = [
	preload("res://overlays/Damage/DamageSplatter/BloodSplatter1.png"),
	preload("res://overlays/Damage/DamageSplatter/BloodSplatter2.png"),
	preload("res://overlays/Damage/DamageSplatter/BloodSplatter3.png"),
	preload("res://overlays/Damage/DamageSplatter/BloodSplatter4.png"),
]


@onready var SplatterAlpha = modulate.a
@onready var SplatterTimer = $Timer

const POSITION_OFFSET = Vector2(-50, -10)
const SCALE_BASE = Vector2(3.5, 3.5)
const SCALE_MODIFIER = 1.0
const ROTATION_MODIFIER = 30.0
const VISIBLE_TIME = 1.0


func _ready() -> void:
	#texture = SplatterDecals[randi() % SplatterDecals.size() - 1]
	var windowSize = DisplayServer.window_get_size(0)
	position = Vector2((randi() % windowSize.x) + POSITION_OFFSET.x, (randi() % windowSize.y) + POSITION_OFFSET.y)
	scale = SCALE_BASE * (randf() * SCALE_MODIFIER)
	rotation_degrees = (randf() * ROTATION_MODIFIER) / 2.0
	SplatterTimer.wait_time = VISIBLE_TIME
	SplatterTimer.start()


func _process(delta: float) -> void:
	if SplatterAlpha <= 0.0:
		queue_free()
	
	modulate.a = SplatterTimer.time_left / VISIBLE_TIME
