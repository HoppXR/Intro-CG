Shader "HoppXR/WaterShader"
{
    Properties
    {
        _MainTex ("Water", 2D) = "white" {}
        _FoamTex ("Foam", 2D) = "White" {}
        _BumpMap ("Normal Map", 2D) = "Bump" {}
        _Freq ("Frequency", Range(0,5)) = 3
        _Speed ("Speed", Range(0,100)) = 10
        _Amp ("Amplitude", Range(0,1)) = 0.5
        
        _ScrollX ("Scroll X", Range(-5,5)) = 1
        _ScrollY ("Scroll Y", Range(-5,5)) = 1
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert vertex:vert

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_BumpMap;
            float3 vertColor;
        };

        float _Freq;
        float _Speed;
        float _Amp;

        float _ScrollX;
        float _ScrollY;

        struct appdata
        {
            float4 vertex : POSITION;
            float3 normal : NORMAL;
            float4 tangent : TANGENT;
            float4 texcoord : TEXCOORD0;
        };
        
        void vert(inout appdata v, out Input o)
        {
            UNITY_INITIALIZE_OUTPUT(Input, o);
            float t = _Time * _Speed;
            float waveHeight = sin(t + v.vertex.x * _Freq) * _Amp + sin(t*2 + v.vertex.x * _Freq*2) * _Amp;
            v.vertex.y = v.vertex.y + waveHeight;
            v.normal = normalize(float3(v.normal.x + waveHeight, v.normal.y, v.normal.z));
            o.vertColor = waveHeight + 2;
        }

        sampler2D _MainTex;
        sampler2D _FoamTex;
        sampler2D _BumpMap;
        void surf(Input IN, inout SurfaceOutput o)
        {
            _ScrollX *= _Time;
            _ScrollY *= _Time;
            float3 water = tex2D(_MainTex, IN.uv_MainTex + float2(_ScrollX, _ScrollY)).rgb;
            float3 foam = tex2D(_FoamTex, IN.uv_MainTex + float2(_ScrollX/2, _ScrollY/2));

            float3 normalMap = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
            o.Normal = normalize(normalMap);
            
            o.Albedo = (water + foam) * 0.5;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
