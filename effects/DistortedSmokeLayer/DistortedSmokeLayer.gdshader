//Shader Source:
//https://godotshaders.com/shader/distortion-based-on-noise-texture/

shader_type canvas_item;
render_mode unshaded;

uniform float alpha : hint_range(0.0, 1.0) = 1.0;
uniform sampler2D albedo_texture : source_color, filter_nearest, repeat_enable;
uniform sampler2D noise_texture : source_color, filter_nearest, repeat_enable;

uniform float speed : hint_range(0.0, 2.0, 0.005) = 0.5;
uniform float distortion : hint_range(0.0, 0.3, 0.005) = 0.03;

uniform vec2 uv1_scale = vec2(1.0,1.0);
uniform vec2 uv1_offset = vec2(0.0, 0.0);


void vertex()
{
	UV = UV * uv1_scale + uv1_offset;

}

void fragment() {
	vec2 noiseValue  = (texture(noise_texture, UV + (TIME * speed)).rg * 2.0) - 1.0; // Range: -1.0 to 1.0

	vec2 noiseDistortion = (noiseValue * distortion);

	vec4 colour = texture(albedo_texture, UV + noiseDistortion);

	COLOR = vec4(colour.rgb, alpha * colour.a);
}