Shader "Custom/FirstShader"
{
    Properties
    {
        _myColor ("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        struct Input
        {
            float2 uv_MainTex;
        };
        
        fixed4 _myColor;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            o.Albedo = _myColor.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
