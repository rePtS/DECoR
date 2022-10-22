#include "Common.hlsli"

Texture2D TexDiffuse : register(t0);

struct SPoly
{
    float4 Pos : Position0;
    float3 Color : Color0;
    float2 TexCoord : TexCoord0;
    uint PolyFlags : BlendIndices0;
};

struct VSOut
{
    float4 Pos : SV_Position;
    float3 Color : Color0;
    float2 TexCoord : TexCoord0;
    uint PolyFlags : BlendIndices0;
};

VSOut VSMain(const SPoly Input)
{
    VSOut Output;
    Output.Pos = mul(Input.Pos, ProjectionMatrix);
    Output.Color = Input.Color;
    Output.TexCoord = Input.TexCoord;
    Output.PolyFlags = Input.PolyFlags;
    return Output;
}

float4 PSMain(const VSOut Input) : SV_Target
{
    float4 Color = float4(Input.Color, 1.0f);

    if (Input.PolyFlags & (PF_Masked | PF_Modulated))
    {
        clip(TexDiffuse.Sample(SamPoint, Input.TexCoord).a - 0.5f);	
    }

    if (Input.PolyFlags & PF_Modulated)
    {
        return TexDiffuse.Sample(SamPoint, Input.TexCoord);
    }

    const float3 Diffuse = TexDiffuse.Sample(SamLinear, Input.TexCoord).rgb;
    Color.rgb *= Diffuse;

    return Color;
}
