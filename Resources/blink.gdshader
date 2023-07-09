shader_type canvas_item;

void fragment() {
	COLOR = mix(texture(TEXTURE, UV), vec4(0, 0, 0, 0), abs(sin(TIME * 1.0)));
}
