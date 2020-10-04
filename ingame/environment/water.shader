// source: https://www.shadertoy.com/view/wt2GRt
shader_type canvas_item;

uniform vec4 texture_color;

uniform float zoom;
uniform float speed;
uniform float bright;

void fragment() {
	vec4 k = vec4(TIME) * speed;
	k.xy = UV * zoom;
	float val1 = length(0.5-fract(k.xyw*=mat3(vec3(-2.0,-1.0,0.0), vec3(3.0,-1.0,1.0), vec3(1.0,-1.0,-1.0))*0.5));
	float val2 = length(0.5-fract(k.xyw*=mat3(vec3(-2.0,-1.0,0.0), vec3(3.0,-1.0,1.0), vec3(1.0,-1.0,-1.0))*0.2));
	float val3 = length(0.5-fract(k.xyw*=mat3(vec3(-2.0,-1.0,0.0), vec3(3.0,-1.0,1.0), vec3(1.0,-1.0,-1.0))*0.5));
	COLOR = vec4 (pow(min(min(val1,val2),val3), 7.0) * bright)+texture_color;
}