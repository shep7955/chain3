shader_type spatial;

render_mode diffuse_lambert, cull_back, shadows_disabled, depth_draw_opaque, unshaded;


uniform float precision_multiplier : hint_range(0.0, 1.0) = 1.0;
uniform vec4 modulate_color : source_color = vec4(1.0);
uniform sampler2D albedoTex : source_color, filter_nearest;
uniform vec2 uv_scale = vec2(1.0, 1.0);
uniform vec2 uv_offset = vec2(.0, .0);
uniform bool billboard = false;
uniform bool y_billboard = false;
uniform vec2 uv_pan_velocity = vec2(0.0);



// https://github.com/dsoft20/psx_retroshader/blob/master/Assets/Shaders/psx-vertexlit.shader
const vec2 base_snap_res = vec2(160.0, 120.0);
vec4 get_snapped_pos(vec4 base_pos)
{
	vec4 snapped_pos = base_pos;
	snapped_pos.xyz = base_pos.xyz / base_pos.w; // convert to normalised device coordinates (NDC)
	vec2 snap_res = floor(base_snap_res * precision_multiplier);  // increase "snappy-ness"
	snapped_pos.x = floor(snap_res.x * snapped_pos.x) / snap_res.x;  // snap the base_pos to the lower-vertex_resolution grid
	snapped_pos.y = floor(snap_res.y * snapped_pos.y) / snap_res.y;
	snapped_pos.xyz *= base_pos.w;  // convert back to projection-space
	return snapped_pos;
}

void vertex()
{
	UV = UV * uv_scale + uv_offset;
	UV += uv_pan_velocity * TIME;

	if (y_billboard)
	{
		MODELVIEW_MATRIX = INV_VIEW_MATRIX * mat4(VIEW_MATRIX[0],MODEL_MATRIX[1],vec4(normalize(cross(VIEW_MATRIX[0].xyz,MODEL_MATRIX[1].xyz)), 0.0),MODEL_MATRIX[3]);
		MODELVIEW_MATRIX = MODELVIEW_MATRIX * mat4(vec4(1.0, 0.0, 0.0, 0.0),vec4(0.0, 1.0/length(MODEL_MATRIX[1].xyz), 0.0, 0.0), vec4(0.0, 0.0, 1.0, 0.0),vec4(0.0, 0.0, 0.0 ,1.0));
	}
	else if (billboard)
	{
		MODELVIEW_MATRIX = INV_VIEW_MATRIX * mat4(VIEW_MATRIX[0],VIEW_MATRIX[1],VIEW_MATRIX[2],MODEL_MATRIX[3]);
	}


	POSITION = get_snapped_pos(PROJECTION_MATRIX * MODELVIEW_MATRIX * vec4(VERTEX, 1.0));  // snap position to grid
	POSITION /= abs(POSITION.w);  // discard depth for affine mapping

	if (y_billboard)
	{
		MODELVIEW_MATRIX = INV_VIEW_MATRIX * mat4(VIEW_MATRIX[0],VIEW_MATRIX[1],VIEW_MATRIX[2],VIEW_MATRIX[3]);
		MODELVIEW_MATRIX = MODELVIEW_MATRIX * mat4(vec4(length(MODEL_MATRIX[0].xyz), 0.0, 0.0, 0.0),
												vec4(0.0, length(MODEL_MATRIX[1].xyz), 0.0, 0.0),
												vec4(0.0, 0.0, length(MODEL_MATRIX[2].xyz), 0.0),
												vec4(0.0, 0.0, 0.0, 1.0));
	}

	VERTEX = VERTEX;  // it breaks without this - not sure why
}

void fragment()
{
	vec4 tex = texture(albedoTex, UV) * modulate_color * COLOR;
	ALBEDO = tex.rgb;
	if(tex.a < 1.0)
	{
		if(tex.a < 0.1)
		{
			discard;
		}
		else if(((int(FRAGCOORD.x)) % 2 == 0) == ((int(FRAGCOORD.y)) % 2 != 0))
		{
			discard;
		}
	}
}
