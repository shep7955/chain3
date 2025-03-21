//Original shader source:
//https://godotshaders.com/shader/2d-radial-distortion-fisheye-barrel/

/////////////////////////////////
// 2D Radial Distortion Shader //
/////////////////////////////////

// Screen space shader for Godot, based on: https://gist.github.com/aggregate1166877/a889083801d67917c26c12a98e7f57a7

shader_type canvas_item;

uniform sampler2D albedo_tex : source_color, filter_nearest;
uniform float distortion = 1.0;
uniform float radius = 1.0;
uniform bool use_tex_alpha = false;
uniform float alpha : hint_range(0.0, 1.0, 0.03125) = 1.0;
uniform float crop = 1.0;
uniform bool shade = true;


vec2 distort(vec2 p)
{
	float d = length(p);
	float z = sqrt(distortion + d * d * -distortion);
	float r = atan(d, z) / 3.1415926535;
	float phi = atan(p.y, p.x);
	return vec2(r * cos(phi) + 0.5, r * sin(phi) + 0.5);
}

void fragment()
{
	vec2 xy = (UV * 2.0 - 1.0); // move origin of UV coordinates to center of screen

	float d = length(xy); // distance from center

	vec4 tex;

	if (d < radius)
	{
		xy = distort(xy);
		tex = texture(albedo_tex, xy);
		if(shade)
		{
			tex *= clamp((1.5 - d), 0.0, 1.1);
		}

		COLOR = tex * alpha;
		if(!use_tex_alpha)
		{
			COLOR.a = alpha;
		}

	}
	else
	{
		discard;
	}
}