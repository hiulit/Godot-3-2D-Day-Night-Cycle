shader_type canvas_item;
render_mode blend_mul;

uniform vec4 dawn_color : hint_color = vec4(0.86, 0.70, 0.70, 1.0);
uniform vec4 day_color : hint_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 dusk_color : hint_color = vec4(0.59, 0.66, 0.78, 1.0);
uniform vec4 night_color : hint_color = vec4(0.07, 0.09, 0.38, 1.0);

uniform vec4 cycle_color : hint_color = vec4(1.0, 1.0, 1.0, 1.0);

uniform float brightness : hint_range(0.0, 10.0, 0.01) = 1.0;
uniform float contrast : hint_range(0.0, 10.0, 0.01) = 1.0;
uniform float saturation : hint_range(0.0, 10.0, 0.01) = 1.0;
uniform float pop_strength : hint_range(0.0, 10.0, 0.01) = 1.0;
uniform float pop_threslhold : hint_range(0.0, 1.0, 0.01) = 1.0;

uniform sampler2D lights_tex;
uniform bool use_external_lights_tex = true;

void fragment() {
	vec3 base_col = texture(SCREEN_TEXTURE, SCREEN_UV).rgb;
	vec3 out_col = base_col;

	float grey = dot(base_col, vec3(0.299, 0.587, 0.114));
	
	out_col = mix(vec3(grey), out_col, saturation);
	out_col = (out_col - 0.5) * contrast + 0.5;
	out_col = out_col + pop_strength * max(grey - pop_threslhold, 0.0);
	out_col = out_col * brightness;
	
	if (!use_external_lights_tex) {
		COLOR = vec4(out_col * cycle_color.rgb, 1.0) + texture(lights_tex, UV);
		COLOR = vec4((out_col / base_col) * cycle_color.rgb, 1.0) + texture(lights_tex, UV);
//		COLOR = vec4(mix(out_col, cycle_color.rgb, 1.0), 1.0) + texture(lights_tex, UV);
//		COLOR = vec4(mix(out_col, out_col * cycle_color.rgb, 1.0), 1.0) + texture(lights_tex, UV);
	} else {
		COLOR = vec4(out_col * cycle_color.rgb, 1.0);
		COLOR = vec4((out_col / base_col) * cycle_color.rgb, 1.0);
//		COLOR = vec4(mix(out_col, cycle_color.rgb, 1.0), 1.0);
//		COLOR = vec4(mix(out_col, out_col * cycle_color.rgb, 1.0), 1.0);
	}
}