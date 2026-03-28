shader_type canvas_item;

// Control the speed from the Inspector
uniform vec2 scroll_speed = vec2(0.01, 0.0); 

void fragment() {
	// TIME is a built-in Godot variable that counts up forever
	// We add it to the UV coordinates to "slide" the texture
	vec2 moving_uv = UV + (scroll_speed * TIME);
	
	// Apply the new coordinates to the texture
	COLOR = texture(TEXTURE, moving_uv);
}