@tool
extends CompositorEffect
class_name UnderWaterEffect

var shader : RID
var pipeline : RID
var rendering_device: RenderingDevice

func _init():
	RenderingServer.call_on_render_thread(init_shader)
func _notification(what: int) -> void:
	if what == NOTIFICATION_PREDELETE and shader.is_valid():
		RenderingServer.free_rid(shader)

func init_shader() -> void:
	rendering_device = RenderingServer.get_rendering_device()
	if not rendering_device : return
	var shader_file : RDShaderFile = load("res://scenes/CompositorTest/underwater.glsl")
	print(shader_file.get_spirv().compile_error_compute)
	shader = rendering_device.shader_create_from_spirv(shader_file.get_spirv())
	pipeline = rendering_device.compute_pipeline_create(shader)


func _render_callback(_effect_callback_type: int, render_data: RenderData) -> void:
	if not rendering_device : return
	
	var render_scene_buffers : RenderSceneBuffersRD = render_data.get_render_scene_buffers()
	if not render_scene_buffers : return
	
	#var depth_buffer : RID = render_scene_buffers.get_texture("render_buffers", "depth")
	var size : Vector2i = render_scene_buffers.get_internal_size()
	if size.x == 0 or size.y == 0 : return
	var x_group : int = size.x/16 + (1 if (size.x % 16 > 0) else 0)
	var y_group : int = size.y/16 + (1 if (size.y % 16 > 0) else 0)
	
	var push_constants : PackedFloat32Array = PackedFloat32Array()
	push_constants.append(size.x)
	push_constants.append(size.y)
	push_constants.append(0.0)
	push_constants.append(0.0)
	for view in render_scene_buffers.get_view_count():

		var screen_tex : RID = render_scene_buffers.get_color_layer(view)
		#var deph_tex : RID = render_scene_buffers.get_depth_layer(view)
		var uniform : RDUniform = RDUniform.new()
		uniform.uniform_type = RenderingDevice.UNIFORM_TYPE_IMAGE
		uniform.binding = 0
		uniform.add_id(screen_tex)
		
		var image_uniform_set : RID = UniformSetCacheRD.get_cache(shader, 0, [uniform])
		var compute_list : int = rendering_device.compute_list_begin()
		
		rendering_device.compute_list_bind_compute_pipeline(compute_list, pipeline)
		rendering_device.compute_list_bind_uniform_set(compute_list, image_uniform_set, 0)
		rendering_device.compute_list_set_push_constant(compute_list, push_constants.to_byte_array(), push_constants.size() * 4)
		rendering_device.compute_list_dispatch(compute_list, x_group, y_group, 1)
		rendering_device.compute_list_end()
