#version 150

uniform sampler2D InSampler;

in vec2 texCoord;
in vec2 oneTexel;

out vec4 fragColor;

void main(){
    vec4 center = texture(InSampler, texCoord);
    vec4 left = texture(InSampler, texCoord - vec2(oneTexel.x, 0.0));
    vec4 right = texture(InSampler, texCoord + vec2(oneTexel.x, 0.0));
    vec4 up = texture(InSampler, texCoord - vec2(0.0, oneTexel.y));
    vec4 down = texture(InSampler, texCoord + vec2(0.0, oneTexel.y));
    vec3 col = center.rgb;
    col = max(col, left.rgb);
    col = max(col, right.rgb);
    col = max(col, up.rgb);
    col = max(col, down.rgb);
    fragColor = vec4(col, max(max(max(max(center.a, left.a), right.a), up.a), down.a));
}
