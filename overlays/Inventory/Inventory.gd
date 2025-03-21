extends Node2D


@export var Active := false

@onready var SphereMap := $SphereMap
@onready var InventoryVP := $SubViewport
@onready var Cursor := $SubViewport/Cursor
@onready var Camera := $SubViewport/Camera2D

@onready var sndOpen := $sndOpen
@onready var sndClose := $sndClose
@onready var sndCursorMove := $sndCursorMove

var accumulator = 0.0

var Animating := false

var Entries = []
var SelectedEntry := Vector2i.ZERO
var CameraSelectedEntry := Vector2i.ZERO

const DISPLAY_SCALE_ACTIVE = Vector2(1.5, 1.5)
const DISPLAY_SCALE_INACTIVE = Vector2(1.0, 1.0)
const DISPLAY_SCALE_RATE = Vector2(0.5, 0.3)
const DISPLAY_ALPHA_RATE = Vector2(0.4, 0.25)
const CURSOR_MOVE_SPEED = 0.2
const CAMERA_ENTRY_OFFSET = Vector2i(16, 16)

const INVENTORY_DIM = Vector2i(10, 3)
const INVENTORY_ENTRY = preload("res://overlays/Inventory/InventoryEntry.tscn")
const INVENTORY_SPRITE_DIM = 32.0


func _ready() -> void:
	SphereMap.SetViewportTexture(InventoryVP.get_texture())
	
	for i in range(INVENTORY_DIM.x):
		for j in range(INVENTORY_DIM.y):
			var entry = INVENTORY_ENTRY.instantiate()
			InventoryVP.add_child(entry)
			entry.position = Vector2(i, j) * INVENTORY_SPRITE_DIM
	
	DebugMenu.AddMonitor(self, "SelectedEntry")
	


func _physics_process(delta: float) -> void:
	
	if !Active:
		return
	
	if Input.is_action_just_pressed("ui_accept"):
		UseSelectedItem()
	else:
		MoveCursor()
	
	Camera.position = Cursor.position
	


func MoveCursor() -> void:
	if Animating:
		return
	
	var cursorMove := Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
	
	if cursorMove.length() > 0.0:
		var newEntry = SelectedEntry + Vector2i(cursorMove)
		newEntry.x = clamp(newEntry.x, 0, INVENTORY_DIM.x - 1)
		newEntry.y = clamp(newEntry.y, 0, INVENTORY_DIM.y - 1)

		
		if newEntry != SelectedEntry:
			SelectedEntry = newEntry
			Animating = true
			sndCursorMove.play()
			var tween = create_tween()
			tween.tween_property(Cursor, "position", SelectedEntry * INVENTORY_SPRITE_DIM, CURSOR_MOVE_SPEED)
			tween.tween_callback(func(): Animating = false)



func UseSelectedItem() -> void:
	pass


func SetSphereAlpha(alpha: float) -> void:
	SphereMap.SetAlphaLevel(clamp(alpha, 0.0, 1.0))


func FinishOpeningAnim() -> void:
	Active = true
	Animating = false


func FinishClosingAnim() -> void:
	Animating = false


func ActivateCurrentItem() -> void:
	pass


func Toggle() -> void:
	if Animating:
		return
	
	if Active:
		Close()
	else:
		Open()


func Open() -> void:
	Active = false
	Animating = true
	#SphereMap.SetAlphaLevel(0.0)
	scale = DISPLAY_SCALE_INACTIVE
	var tween = create_tween()
	tween.tween_property(self, "scale", DISPLAY_SCALE_ACTIVE, DISPLAY_SCALE_RATE.x)
	tween.parallel().tween_method(SetSphereAlpha, 0.0, 1.0, DISPLAY_ALPHA_RATE.x)
	tween.tween_callback(FinishOpeningAnim)
	sndOpen.play()


func Close() -> void:
	Active = false
	Animating = true
	#SphereMap.SetAlphaLevel(1.0)
	scale = DISPLAY_SCALE_ACTIVE
	var tween = create_tween()
	tween.tween_property(self, "scale", DISPLAY_SCALE_INACTIVE, DISPLAY_SCALE_RATE.y)
	tween.parallel().tween_method(SetSphereAlpha, 1.0, 0.0, DISPLAY_ALPHA_RATE.y)
	tween.tween_callback(FinishClosingAnim)
	sndClose.play()
