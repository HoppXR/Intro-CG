Shader "HoppXR/ColorVertexShader"
{
    Properties
    {
        _ColorLow ("Bottom Color", Color) = (0,1,0,1)
        _ColorMid ("Middle Color", Color) = (1,1,0,1)
        _ColorHigh ("Top Color", Color) = (1,0,0,1)
        _HeightMin ("Min Height", float) = 0
        _HeightMax ("Max Height", float) = 10
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
            };
            struct v2f
            {
                float4 pos : SV_POSITION;
                float height : TEXCOORD0;
            };

            float _HeightMin;
            float _HeightMax;
            float4 _ColorLow;
            float4 _ColorMid;
            float4 _ColorHigh;
            
            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.height = v.vertex.y;
                return o;
            }
            fixed4 frag(v2f i) : SV_Target
            {
                float t = saturate((i.height - _HeightMin) / (_HeightMax - _HeightMin));

                float4 col = lerp(_ColorLow, _ColorHigh, t * 2);

                if (t > 0)
                    col = lerp(_ColorMid, _ColorHigh, t * 2 - 1);
                
                return col * _SinTime;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
