Shader "Ragot/GlobalAndPointLights"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _AmbientLight ("Ambient Light", Range(0, 1)) = 0.2

        // Primera Luz
        _Light1Pos ("Light 1 Position", Vector) = (0, 0, 0, 0)
        _Light1Color ("Light 1 Color", Color) = (1, 1, 1, 1)
        _Light1Intensity ("Light 1 Intensity", Range(0, 5)) = 1
        _Light1Range ("Light 1 Range", Range(0, 10)) = 5

        // Segunda Luz
        _Light2Pos ("Light 2 Position", Vector) = (0, 0, 0, 0)
        _Light2Color ("Light 2 Color", Color) = (1, 1, 1, 1)
        _Light2Intensity ("Light 2 Intensity", Range(0, 5)) = 1
        _Light2Range ("Light 2 Range", Range(0, 10)) = 5
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        struct Input
        {
            float2 uv_MainTex;
            float3 worldPos;
        };

        sampler2D _MainTex;

        float _AmbientLight;

        float4 _Light1Pos;
        float4 _Light1Color;
        float _Light1Intensity;
        float _Light1Range;

        float4 _Light2Pos;
        float4 _Light2Color;
        float _Light2Intensity;
        float _Light2Range;


        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex);

            float dist = distance (IN.worldPos, _Light1Pos.xyz);

            float light1Atten = pow (saturate(1.0 - (dist / _Light1Range)), 2.0);
            float3 light1Contribution = _Light1Color.rgb * light1Atten * _Light1Intensity;

            dist = distance (IN.worldPos, _Light2Pos.xyz);
            float light2Atten = pow ( saturate (1.0 - (dist / _Light2Range)), 2.0);
            float3 light2Contribution = _Light2Color.rgb * light2Atten * _Light2Intensity;

            float3 finalColor = c.rgb * (_AmbientLight + light1Contribution + light2Contribution);

            o.Albedo = finalColor;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
