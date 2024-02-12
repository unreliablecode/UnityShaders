Shader "Unlit/Appear" {
	Properties {
		_MainTex ("Texture", 2D) = "white" {}
		_Color ("Color", Color) = (1,1,1,1)
		_EffectAmount ("Effect Amount", Range(0, 2)) = 1
	}
	SubShader {
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
		Blend SrcAlpha OneMinusSrcAlpha
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			struct appdata {
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f {
				float2 uv : TEXCOORD0;
				fixed4 color : COLOR;
			};

			sampler2D _MainTex;
			fixed4 _Color;
			float _EffectAmount;

			v2f vert(appdata v) {
				v2f o;
				o.uv = v.uv;
				o.color = _Color;
				return o;
			}

			fixed4 frag(v2f i) : SV_Target {
				fixed4 col = tex2D(_MainTex, i.uv) * i.color;
				col.y = col.x - _EffectAmount;
				col.a = col.y <= 0.0 ? 0.0 : 1.0;
				return col;
			}
			ENDCG
		}
	}
}
