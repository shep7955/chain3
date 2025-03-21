//Based on the water shader at https://godotshaders.com/shader/low-poly-water/

shader_type spatial;
render_mode unshaded, diffuse_lambert, cull_back, shadows_disabled, depth_draw_opaque;

uniform float precision_multiplier : hint_range(0.0, 1.0) = 1.0;
uniform vec4 modulate_color : source_color = vec4(1.0);
uniform sampler2D albedoTex : source_color, filter_nearest, repeat_enable;
uniform vec2 uv_scale = vec2(1.0, 1.0);
uniform vec2 uv_offset = vec2(0.0, 0.0);
uniform vec2 uv_pan_velocity = vec2(0.0);
uniform bool enable_fog = true;
uniform float elevation: hint_range(0.2, 5.0, 0.1) = 0.8;
uniform float speed : hint_range(0.1, 5.0, 0.1) = 1.0;
uniform float beer_factor = 0.2;


//directional vertex lighting thanks to enoh32
global uniform vec4 LightAmbient : source_color;
global uniform vec4 LightColour : source_color;
global uniform vec3 LightDir;

//vertex fog thanks to enoh32
global uniform vec4 FogColour : source_color;
global uniform float FogStart;
global uniform float FogEnd;
varying float vFog;


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


float GenerateOffset(float x, float z, float val1, float val2, float time)
{
	float radiansX = ((mod(x + z * x * val1, elevation) / elevation) + (time * speed) * mod(x * 0.8 + z, 1.5)) * 2.0 * PI;
	float radiansZ = ((mod(val2 * (z * x + x * z), elevation) / elevation) + (time * speed) * 2.0 * mod(x, 2.0)) * 2.0 * PI;
	
	return elevation * 0.5 * (sin(radiansZ) * cos(radiansX));
}


vec3 ApplyDistortion(vec3 vertex, float time)
{
	float xd = GenerateOffset(vertex.x, vertex.z, 0.2, 0.1, time);
	float yd = GenerateOffset(vertex.x, vertex.z, 0.1, 0.3, time);
	float zd = GenerateOffset(vertex.x, vertex.z, 0.15, 0.2, time);
	
	return vertex + vec3(xd, yd, zd);
}


void vertex()
{
	UV = UV * uv_scale + uv_offset;
	UV += uv_pan_velocity * TIME;

	
	VERTEX = ApplyDistortion(VERTEX, TIME * 0.1);
	POSITION = PROJECTION_MATRIX * MODELVIEW_MATRIX * vec4(VERTEX, 1.0);
	vec4 posAddon = PROJECTION_MATRIX * MODELVIEW_MATRIX * vec4(0.0, GenerateOffset(VERTEX.x, VERTEX.y, 0.1, 0.3, TIME * 0.001), 0.0, 0.0);
	
	POSITION = get_snapped_pos(POSITION + posAddon);  // snap position to grid
	//POSITION /= abs(POSITION.w);  // discard depth for affine mapping


	VERTEX = VERTEX;  // it breaks without this - not sure why
	
	//vertex fog
	float z = max(0.0, (PROJECTION_MATRIX * MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).z - FogStart);
	vFog = clamp(z / (FogEnd - FogStart), 0.0, 1.0);

	//vertex lighting
	vec3 N = (MODEL_MATRIX * vec4(NORMAL, 0.0)).xyz;
	N = normalize(N);
	float ndl = max(0.0, dot(N, LightDir));
	COLOR.rgb = (LightAmbient.rgb + (LightColour.rgb * ndl)) * COLOR.rgb;
}

void fragment()
{
	ALBEDO = (COLOR * texture(albedoTex, UV) * modulate_color).rgb;
	
	//vertex fog uses the built in fog parameters?
	if(enable_fog)
	{
		FOG.rgb = FogColour.rgb;
		FOG.a = vFog;
	}
}
