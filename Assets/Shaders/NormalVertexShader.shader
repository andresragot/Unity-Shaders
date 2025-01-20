Shader "Ragot/NormalVertexShader"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        struct Input
        {
            float2 uv_MainTex;
            float3 worldNormal;
        };


        sampler2D _MainTex;

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);

            float3 normalColor = IN.worldNormal * 0.5 + 0.5;

            o.Albedo = c.rgb * normalColor;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
