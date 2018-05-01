//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.	
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float Position;

vec3 rgb2hsv ( vec3 color )
{
    vec4 K = vec4 ( 0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0 );
    vec4 p = mix ( vec4 ( color.bg, K.wz ), vec4 ( color.gb, K.xy ), step ( color.b, color.g ) );
    vec4 q = mix ( vec4 ( p.xyw, color.r ), vec4 ( color.r, p.yzx ), step ( p.x, color.r ) );

    float d = q.x - min ( q.w, q.y );
    float e = 1.0e-10;
    return vec3 ( abs ( q.z + ( q.w - q.y ) / ( 6.0 * d + e ) ), d / ( q.x + e ), q.x );
}

vec3 hsv2rgb ( vec3 hsv )
{
    vec4 K = vec4 ( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
    vec3 p = abs ( fract ( hsv.xxx + K.xyz ) * 6.0 - K.www );
    return hsv.z * mix ( K.xxx, clamp ( p - K.xxx, 0.0, 1.0 ), hsv.y );
}

void main ( )
{
    gl_FragColor = texture2D ( gm_BaseTexture, v_vTexcoord ) * v_vColour;
    
    vec3 hsv = rgb2hsv ( gl_FragColor.rgb );
    vec3 shifted_color = vec3 ( hsv.x + Position, hsv.y, hsv.z );
    gl_FragColor.rgb = hsv2rgb ( shifted_color );
    
    gl_FragColor *= v_vColour;
}
