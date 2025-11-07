#version 150

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:avatar_vars.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

#moj_import <minecraft:avatar.glsl>
#moj_import <minecraft:portrait.glsl>

in float vertexDistance;
in vec4 vertexColor;
in vec4 lightMapColor;
in vec4 overlayColor;
in vec2 texCoord0;
in vec2 texCoord1;
in float player;
flat in vec3 portraitColor;

out vec4 fragColor;

void main() {
    if (portraitColor.x > -1.) {
        if (portraitColor.x == 2.) {
            ivec2 headPixel = ivec2(round(texCoord0 * 8. - .5));
            ivec2 truePixel = ivec2(round(texCoord0 * float(AVATAR_SIZE) - .5));
            fragColor = avatarRender(headPixel, truePixel, true);
            if (fragColor.a < .1) discard;
            fragColor.a = 1.;
        } else {
            fragColor = portraitRender(texCoord0, 68./70., portraitColor);
            if (fragColor.a < .1) discard;
        }
        return;
    }

    vec2 uv = texCoord0;
    if (texCoord1.y >= 0.25 || player > 0.) {
        uv = texCoord1;
    }
    vec4 color = texture(Sampler0, uv);
#ifdef ALPHA_CUTOUT
    if (color.a < ALPHA_CUTOUT) {
        discard;
    }
#endif
    color *= vertexColor * ColorModulator;
#ifndef NO_OVERLAY
    color.rgb = mix(overlayColor.rgb, color.rgb, overlayColor.a);
#endif
#ifndef EMISSIVE
    color *= lightMapColor;
#endif
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}
