// Based on: https://www.shadertoy.com/view/WstXR8
shader_type canvas_item;

uniform float col_depth = 15.0;
uniform bool dither_banding = true;
uniform vec2 buffer_size = vec2(427, 240);

const mat4 bayerIndex = mat4(
    vec4(00.0/16.0, 12.0/16.0, 03.0/16.0, 15.0/16.0),
    vec4(08.0/16.0, 04.0/16.0, 11.0/16.0, 07.0/16.0),
    vec4(02.0/16.0, 14.0/16.0, 01.0/16.0, 13.0/16.0),
    vec4(10.0/16.0, 06.0/16.0, 09.0/16.0, 05.0/16.0));

void fragment()
{
	vec2 buf_size = vec2(textureSize(TEXTURE, 0)); //This doesn't work for some reason

	 // sample the texture
	vec2 iResolution = 1.0 / SCREEN_PIXEL_SIZE;
    vec2 uv = FRAGCOORD.xy / iResolution.xy;
    vec4 col = texture(TEXTURE , SCREEN_UV);

    // gamma correction
    col = vec4(pow(col.rgb,vec3(1.2)) - 0.004,col.a);


    // find bayer matrix entry based on fragment position
    float bayerValue = bayerIndex[int(FRAGCOORD.x) % 4][int(FRAGCOORD.y) % 4];

	//bayerValue -= 0.5;

        // output
     //COLOR = vec4(
       //     step(bayerValue,col.r),
        //    step(bayerValue,col.g),
         //   step(bayerValue,col.b),
          //  col.a);
	COLOR.rgb = round(col.rgb * col_depth + bayerValue * (dither_banding ? 1.0 : 0.0)) / col_depth;
}

/* //Old one that doesn't work anymore due to the buf_size issue
	//What's great is that it's not from requesting the buffer size, hardcoding the values just recreates the problem

	hader_type canvas_item;
// originally based on https://github.com/WittyCognomen/godot-psx-shaders-demo/blob/master/shaders/psx_dither_post.shader

uniform sampler2D dither_tex: source_color, filter_nearest;
uniform float col_depth = 15.0;
uniform bool dither_banding = true;

void fragment() {
	vec2 dith_size = vec2(textureSize(dither_tex,0)); // for GLES2: substitute for the dimensions of the dithering matrix
	vec2 buf_size = vec2(textureSize(TEXTURE,0));

	COLOR = texture(TEXTURE, SCREEN_UV);

	vec3 dith = texture(dither_tex, SCREEN_UV * (buf_size / dith_size)).rgb;
	dith -= 0.5;
	COLOR.rgb = round(COLOR.rgb * col_depth + dith * (dither_banding ? 1.0 : 0.0)) / col_depth;
}

*/