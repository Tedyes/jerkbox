//SHADERTOY PORT FIX
#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main
#define time iTime
//SHADERTOY PORT FIX

#define REFRESHES_PER_SECOND 1024.
#define NOISE_AMOUNT 0.
#define NOISE_DENSITY 0.
#define ROW_SIZE 1.
#define COL_SIZE 1.

float rand(vec2 co){
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

float timeToRefresh = 0.;
float rowSize = ROW_SIZE;
float colSize = COL_SIZE;
float offset = 0.;

void mainImage()
{   

    offset = 0.25*floor(iTime*REFRESHES_PER_SECOND);
    float sizeNoise = floor(iTime*REFRESHES_PER_SECOND);
    rowSize = (rand(vec2(sizeNoise*0.23, sizeNoise*6.1))*0.5 + 0.5)*ROW_SIZE;
    colSize = (rand(vec2(sizeNoise*4.7, sizeNoise*0.36))*0.5 + 0.5)*COL_SIZE;
       
    float numRows = ceil(iResolution.y/rowSize);
    float numCols = ceil(iResolution.x/colSize);
    
    vec2 pos = vec2(floor(fragCoord.y / rowSize), floor(fragCoord.x / colSize));
    vec2 rectPos = vec2(mod(fragCoord.x, colSize), mod(fragCoord.y, rowSize));
    
    // possibly take from nearby row or column instead
    
    float rowNoise = floor((rand(pos)-0.5)*10.);
    float colNoise = floor((rand(pos*0.23)-0.5)*10.);
    
    float targetRow = rowNoise + pos.x;
    float targetCol = colNoise + pos.y;
    
    vec2 fc = (rectPos + vec2(targetCol*colSize, targetRow*rowSize));
    
    if(rand(floor(fc/ROW_SIZE)) < 0.6) fc = fragCoord; //preserve some of original image
    
    vec2 uv = fc / iResolution.xy;
    
    vec4 ou = texture(iChannel0, uv);

    float seed = rand(uv.xy * iTime);
    
    float noiseAmount = (rand(pos*0.683*offset)+0.5)*NOISE_AMOUNT;
    float noiseDensity = rand(pos*0.152*offset)/NOISE_DENSITY;
       
    if(rand(fragCoord.xy * iTime) < noiseAmount &&
       rand(pos * offset) > noiseDensity){
       ou = vec4(seed, seed, seed, 1.0);
    }
    fragColor = ou;
}