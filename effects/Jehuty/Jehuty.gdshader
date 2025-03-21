shader_type spatial;
render_mode unshaded;

uniform sampler2D albedoTex : source_color, filter_nearest, repeat_enable;

varying float PulseY;

void vertex()
{
	//PulseY = (TIME - float(int(TIME)));
	PulseY = mod(TIME, 2.0);
}

void fragment() 
{
	vec3 col = texture(albedoTex, UV).rgb;
	
	if(col.b == 0.0)
	{
		if(round(UV.y * 100.0) == round(PulseY * 100.0))
		{
			ALBEDO = vec3(1.0, 1.0, 1.0);
		}
		else if(UV.y < PulseY)
		{
			if(UV.y > PulseY - 0.1)
			{
				ALBEDO = vec3(0.0, UV.y / (PulseY * 4.0), 0.0);
			}
			else
			{
				ALBEDO = vec3(0.0, 0.0, 0.0);
			}
		}
		else
		{
			ALBEDO = vec3(0.0, 0.0, 0.0);
		}
	}
	else
	{
		ALBEDO = vec3(UV.y * 0.25, 0.0, 0.0);
	}
	
}
