shader_type canvas_item;

uniform bool enabled = false;
uniform vec4 color: source_color;

void fragment() 
{
	vec2 size = TEXTURE_PIXEL_SIZE * 1.0;
	
    float outline = texture(TEXTURE, UV + vec2(-size.x, 0)).a;
    outline += texture(TEXTURE, UV + vec2(0, size.y)).a;
    outline += texture(TEXTURE, UV + vec2(size.x, 0)).a;
    outline += texture(TEXTURE, UV + vec2(0, -size.y)).a;
    outline = min(outline, 1.0);

	vec4 new_color = color;
	if (enabled)
	{
		vec4 col_in = texture(TEXTURE, UV);
		COLOR = mix(col_in, new_color, outline - col_in.a);
	}
}
