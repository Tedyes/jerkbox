#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

void mainImage()
{
    // Parameters
    float topLeftSkew = 0.1;  // Strength of the top left skew
    float topRightSkew = 0.1; // Strength of the top right skew
    float preventRepeat = 0.; // 1 to prevent the texture from repeating itself on the edges

    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    vec2 uv2 = uv;

    // Apply a sine wave to add motion
    float tl = (0.5 + sin(iTime) * 0.5) * topLeftSkew;
    float tr = (0.5 + cos(iTime) * 0.5) * topRightSkew;

    // Warp X
    float dxl = tl * uv.y;
    float dxr = tr * uv.y;
    uv2.x = uv2.x * (1. + dxr) * (1. + dxl) - dxl;
    
    // Warp Y
    float dyl = tl * (1. - uv.x);
    float dyr = tr * uv.x;
    uv2.y = uv2.y * (1. + dyl) * (1. + dyr);
    
    // Clamp (optional)
    uv2 = preventRepeat * clamp(uv2, 0.0, 1.0) + (1. - preventRepeat) * uv2;

    // Pixel color
	vec3 texture = texture(iChannel0, uv2).rgb;

    // Output to screen
    fragColor = vec4(texture, 1.0);
}