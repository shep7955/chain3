shader_type spatial;


const vec2 screen_size = vec2(854.0, 480.0);

varying float vertexZ;

void vertex() {
	// Called for every vertex the material is visible on.
	vertexZ = VERTEX.z;
}

void fragment()
{
	if(vertexZ < 0.0)
		discard;

	float depth = FRAGCOORD.z * 16.0;
	ALBEDO = vec3(depth, 0.0, 0.0);

	//if(depth > 1.0)
	//{
		vec2 local_dist = FRAGCOORD.xy;
		if(distance(FRAGCOORD.xy, vec2(0.5, 0.5) * screen_size) > 0.5)
		{
			//discard;
		}
	//}
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
