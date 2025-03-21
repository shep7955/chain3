shader_type spatial;

render_mode unshaded, depth_draw_always;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;


void fragment()
{
	//DEPTH = VERTEX.z;
	//DEPTH = 0.5;
	//ALPHA = 0.0;
	//ALBEDO = vec3(1.0, 0.0, 0.0);
	ALBEDO = textureLod(SCREEN_TEXTURE, SCREEN_UV, 0.0).rgb;
}
