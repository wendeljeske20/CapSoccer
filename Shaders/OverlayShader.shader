shader_type canvas_item;
render_mode unshaded;

uniform sampler2D displace : hint_albedo;
uniform float dispAmt : hint_range(0, 0.1);
uniform float dispScale : hint_range(0.1, 2.0);
uniform float abberationAmt : hint_range(0, 0.1);
uniform float timeLine : hint_range(0.0, 10.0);

void fragment() {
	// Disp
	vec2 dispUv = SCREEN_UV + vec2(0, TIME * 0.1);
	dispUv *= dispScale;
	vec2 disp = texture(displace, dispUv).xy;
	vec2 noiseUV = SCREEN_UV + disp * dispAmt;
	
	// NOISE
	float noise = texture(SCREEN_TEXTURE, noiseUV).r;
	
	// H LINES
	float h = SCREEN_UV.y * 4.0 - TIME;
	h = clamp(1.0 - (abs(sin(h)) * 3.0), 0.0, 1.0);
	
	float clampedHLine = clamp(h * noise, 0.15, 1.0);
	
	float hLine = clampedHLine * noise;
	hLine *= 0.2;
	
	// Center "ball" thingy
	vec2 cUv = SCREEN_UV * 2.0 - 1.0;
	float tLine = pow(timeLine,2)*0.2;
	float modTLine = clamp(tLine / 4.0, 1.0, 8.0);
	modTLine = pow(modTLine, 2.5);
	cUv *= vec2(modTLine, tLine);
	
	float cBall =  2.0 * ((1.0 - length(cUv)) - 0.5);
	float cLine = pow(1.0 - length(vec2(cUv.g, 0.0)), 12.0);
	
	float center = 10.0 * ((cBall + cLine) - 0.1);
	
	float t = timeLine / 10.0;
	float final = (1.0-t)*hLine+t*center;
	
	// Abberation
	COLOR.r = texture(SCREEN_TEXTURE, noiseUV - abberationAmt * h).r;
	COLOR.g = texture(SCREEN_TEXTURE, noiseUV).g;
	COLOR.b = texture(SCREEN_TEXTURE, noiseUV + abberationAmt * h).b;
	COLOR.a = texture(SCREEN_TEXTURE, noiseUV).a;
	
	COLOR.rgb += vec3(final);
}