static const uint PF_Masked = 0x00000002;
static const uint PF_Modulated = 0x00000040;

cbuffer CBufGlobal : register(b0)
{
    float4 fRes;
    matrix ProjectionMatrix;
};

sampler SamLinear : register(s0);
sampler SamPoint : register(s1);
