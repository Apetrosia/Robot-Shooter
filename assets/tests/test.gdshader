shader_type spatial;

uniform sampler2D noise;
uniform vec3 color1: source_color;
uniform vec3 color2: source_color;
uniform float amplitude;
uniform float speed;

float get_value(vec2 uv) {
	float value2 = texture(noise, uv + vec2(TIME * speed * 1.3, 0)).x;
	float value1 = texture(noise, uv + vec2(0, TIME * speed)).x;
	float value = (value1 + value2) * 0.5;
	return value * value * value * value;
}

void vertex() {
	VERTEX.y += get_value(UV) * amplitude;
}

void fragment() {
	float value = get_value(UV);
	ALBEDO = value * color1 + color2 * (1.0 - value);
}

