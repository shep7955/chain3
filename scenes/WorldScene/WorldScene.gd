extends Node


@onready var TMVP = $TilemapVP
@onready var TileCam = $TilemapVP/Camera2D
@onready var TileLayer = $TilemapVP/WorldTilemap

@onready var SphereMap = $SphereWorld/SphereMap

@onready var Mode7Sky = $Background/Mode7_Sky
@onready var Mode7Ground = $Background/Mode7_Ground

@onready var WorldRender = $ObjectsVP/World3DRender

@onready var Inventory = $Inventory

@onready var Player = $TilemapVP/TilePlayer


const WORLD_RENDER_SCALE = Vector2(-0.006, -0.01)
const TILE_CAM_MOVE_MOD = 145.0
const CAM_SNAP = 0.001
const TILE_SNAP = 1.0


func _ready() -> void:
	SphereMap.SetViewportTexture(TMVP.get_texture())
	
	Mode7Sky.SetDepth(Vector2(0, -0.85))
	Mode7Ground.SetDepth(Vector2(0, 0.85))
	
	WorldRender.AddTileObject(Player)
	
	DebugMenu.AddMonitor(TileCam, "position")


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ToggleInventory"):
		Inventory.Toggle()
	
	Globals.TileItemBobAccumulator += delta
	
	TileCam.position = Player.position # Vector2(80, 120)
	
	WorldRender.WorldOffset = (Player.position + Vector2(0.0, 60.0)).rotated(deg_to_rad(90.0))#.snappedf(CAM_SNAP)

	
	HandleBackground(delta * 0.25)
	
	#TileCam.position += SkyPos * 50.0


func HandleBackground(delta: float) -> void:
	var SkyPos := Vector2.ONE * 0.1
	
	Mode7Sky.Pos += SkyPos * delta
	Mode7Sky.Rot += 0.025 * delta
	Mode7Ground.Pos += (SkyPos * Vector2(1.0, -1.0)) * delta
	Mode7Ground.Rot += 0.05 * delta


func _on_tile_player_nearby_object(object: TileObject) -> void:
	WorldRender.AddTileObject(object)
