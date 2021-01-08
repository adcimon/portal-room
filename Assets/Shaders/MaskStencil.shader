Shader "Custom/Mask Stencil"
{
	Properties
	{
		[Header(Stencil)]
		_StencilRef("Reference Value [0, 255]", Float) = 0
		_StencilReadMask("Read Mask [0, 255]", Int) = 255
		_StencilWriteMask("Write Mask [0, 255]", Int) = 255
		[Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp("Compare Function", Int) = 8
		[Enum(UnityEngine.Rendering.StencilOp)] _StencilPass("Pass Operation", Int) = 0
		[Enum(UnityEngine.Rendering.StencilOp)] _StencilFail("Fail Operation", Int) = 0
		[Enum(UnityEngine.Rendering.StencilOp)] _StencilZFail("Z Fail Operation", Int) = 0
	}

		SubShader
		{
			Pass
			{
				Tags { "Queue" = "Geometry-1" }

				Cull Back
				ZWrite Off
				BlendOp Min

				Stencil
				{
					Ref[_StencilRef]
					ReadMask[_StencilReadMask]
					WriteMask[_StencilWriteMask]
					Comp[_StencilComp]
					Pass[_StencilPass]
					Fail[_StencilFail]
					ZFail[_StencilZFail]
				}

				HLSLPROGRAM
				#pragma vertex Vertex
				#pragma fragment Fragment
				#include "UnityCG.cginc"

				struct Attributes
				{
					float4 positionOS : POSITION;
				};

				struct Varyings
				{
					float4 positionCS : SV_POSITION;
				};

				Varyings Vertex( Attributes input )
				{
					Varyings output;
					output.positionCS = UnityObjectToClipPos(input.positionOS);
					return output;
				}

				half4 Fragment( Varyings input ) : SV_TARGET
				{
					return half4(1, 1, 1, 1);
				}
				ENDHLSL
			}
		}
}