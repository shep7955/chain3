shader_type spatial;
render_mode unshaded, diffuse_lambert, cull_back, shadows_disabled, depth_draw_opaque;

uniform float precision_multiplier : hint_range(0.0, 1.0) = 1.0;
uniform vec4 modulate_color : source_color = vec4(1.0);
uniform sampler2D albedoTex : source_color, filter_nearest, repeat_enable;
uniform bool enable_fog = true;

//vertex fog thanks to enoh32
global uniform vec4 FogColour : source_color;
global uniform float FogStart;
global uniform float FogEnd;
varying float vFog;

varying vec3 eyePos;

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
	POSITION = get_snapped_pos(PROJECTION_MATRIX * MODELVIEW_MATRIX * vec4(VERTEX, 1.0));  // snap position to grid
	POSITION /= abs(POSITION.w);  // discard depth for affine mapping

	VERTEX = VERTEX;  // it breaks without this - not sure why
	
	
	//vertex fog
	float z = max(0.0, (PROJECTION_MATRIX * MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).z - FogStart);
	vFog = clamp(z / (FogEnd - FogStart), 0.0, 1.0);
}

void fragment()
{
	vec2 newUV = (normalize(NORMAL).xy * vec2(0.5, -0.5) + vec2(0.5));
	
	ALBEDO = (COLOR * texture(albedoTex, newUV) * modulate_color).rgb;
	
	//vertex fog uses the built in fog parameters?
	if(enable_fog)
	{
		FOG.rgb = FogColour.rgb;
		FOG.a = vFog;
	}
}
