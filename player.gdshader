shader_type canvas_item;

uniform sampler2D screen_texutre :hint_screen_texture;

void fragment() {
	// Called for every pixel the material is visible on.
	COLOR = vec4(texture(screen_texutre,SCREEN_UV).rgb,texture(TEXTURE,UV).a);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
