extends Node


var FPS := 0.0
var StaticMemory := ""
var DynamicMemory := ""

var ObjectCount := 0.0
var OrphanNodes := 0.0

var TextureMemory := ""
var MaterialChanges := 0.0
var VertexCount := 0.0
var DrawCalls := 0.0

var Uptime := 0.0


func _ready():
	AddSystemMonitors()


func _process(_delta):
	FPS = Performance.get_monitor(Performance.TIME_FPS)
	StaticMemory = BytesFormatted(Performance.get_monitor(Performance.MEMORY_STATIC))
	ObjectCount = Performance.get_monitor(Performance.OBJECT_COUNT)
	#MaterialChanges = Performance.get_monitor(Performance.RENDER_MATERIAL_CHANGES_IN_FRAME)
	OrphanNodes = Performance.get_monitor(Performance.OBJECT_ORPHAN_NODE_COUNT)
	#VertexCount = (Performance.get_monitor(Performance.RENDER_VERTICES_IN_FRAME))
	#DrawCalls = Performance.get_monitor(Performance.RENDER_DRAW_CALLS_IN_FRAME)
	#DynamicMemory = BytesFormatted(Performance.get_monitor(Performance.MEMORY_DYNAMIC))
	TextureMemory = BytesFormatted(Performance.get_monitor(Performance.RENDER_TEXTURE_MEM_USED))
	Uptime = Time.get_ticks_msec() / 1000.0
	

func BytesFormatted(text):
	var byteAmount = int(text)
	if byteAmount / (1024.0 * 1024.0) > 1:
		return "%s MB" % (byteAmount / (1024.0 * 1024.0))
	if byteAmount / 1024.0 > 1:
		return "%s KB" % (byteAmount / 1024.0)
	return "%s B" % byteAmount


func AddSystemMonitors():
	DebugMenu.AddMonitor(SystemMonitor, "FPS")
	DebugMenu.AddMonitor(SystemMonitor, "StaticMemory")
	DebugMenu.AddMonitor(SystemMonitor, "DynamicMemory")
	DebugMenu.AddMonitor(SystemMonitor, "ObjectCount")
	DebugMenu.AddMonitor(SystemMonitor, "OrphanNodes")
	DebugMenu.AddMonitor(SystemMonitor, "TextureMemory")
	DebugMenu.AddMonitor(SystemMonitor, "MaterialChanges")
	DebugMenu.AddMonitor(SystemMonitor, "VertexCount")
	DebugMenu.AddMonitor(SystemMonitor, "DrawCalls")
	DebugMenu.AddMonitor(SystemMonitor, "Uptime")
