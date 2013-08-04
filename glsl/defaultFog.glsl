// Fog shader

#include "include/uniforms.glsl"
#include "include/fog.glsl"

varying vec2 v_FogCoord;

#ifdef VERTEX_SHADER

#include "include/attributes.glsl"
#include "include/vtransform.glsl"

void main(void)
{
	vec4 Position = a_Position;
	vec3 Normal = a_Normal;
	vec2 TexCoord = a_TexCoord;

	TransformVerts(Position, Normal, TexCoord);

	FogGen(Position, v_FogCoord);

	gl_FrontColor = vec4(u_Fog.Color, 1.0);

	gl_Position = u_ModelViewProjectionMatrix * Position;
}

#endif // VERTEX_SHADER

#ifdef FRAGMENT_SHADER
// Fragment shader

void main(void)
{
	float fogDensity = FogDensity(v_FogCoord);
	gl_FragColor = vec4(gl_Color.rgb, fogDensity);
}

#endif // FRAGMENT_SHADER

