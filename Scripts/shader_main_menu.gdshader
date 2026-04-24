shader_type canvas_item;

// Control the speed (0.05 is usually good)
uniform float scroll_speed = 0.05;

void fragment() {
	// 1. Get the screen ratio so the image doesn't stretch
	// This keeps your pixels "square" regardless of screen size
	vec2 moving_uv = vec2(UV.x + (TIME * scroll_speed), UV.y);
	
	// 2. Use the 'texture' function with our moving coordinates
	// 'COLOR' is the final pixel color on the screen
	COLOR = texture(TEXTURE, moving_uv);
}