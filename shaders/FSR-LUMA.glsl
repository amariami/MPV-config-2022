// Copyright (c) 2021 Advanced Micro Devices, Inc. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

// FidelityFX FSR by AMD
// ported to mpv by agyild

// Changelog
// Made it compatible with pre-OpenGL 4.0 renderers
// Made it directly operate on LUMA plane, since the original shader was operating on LUMA by deriving it from RGB. This should cause a major increase in performance, especially on OpenGL 4.0+ renderers (4+2 texture lookups vs. 12+5)
// Removed transparency preservation mechanism since the alpha channel is a separate source plan than LUMA
// 
// Notes
// Per AMD's guidelines only upscales content up to 4x (e.g., 1080p -> 2160p, 720p -> 1440p etc.) and everything else in between, if
// you want to disable this upper limit replace the WHEN directive with "OUTPUT.w OUTPUT.h * LUMA.w LUMA.h * / 1.0 >".
// default "OUTPUT.w OUTPUT.h * LUMA.w LUMA.h * / 4.0 > ! OUTPUT.w OUTPUT.h * LUMA.w LUMA.h * / 1.0 > *".

//!HOOK LUMA
//!BIND HOOKED
//!SAVE EASUTEX
//!DESC FidelityFX Super Resolution 1.0 (EASU)
//!WHEN OUTPUT.w OUTPUT.h * LUMA.w LUMA.h * / 1.0 >
//!WIDTH OUTPUT.w
//!HEIGHT OUTPUT.h
//!COMPONENTS 1

// Shader code

float APrxLoRcpF1(float a) {
	return uintBitsToFloat(uint(0x7ef07ebb) - floatBitsToUint(a));
}

float APrxLoRsqF1(float a) {
	return uintBitsToFloat(uint(0x5f347d74) - (floatBitsToUint(a) >> uint(1)));
}

float AMin3F1(float x, float y, float z) {
	return min(x, min(y, z));
}

float AMax3F1(float x, float y, float z) {
	return max(x, max(y, z));
}

 // Filtering for a given tap for the scalar.
 void FsrEasuTap(
	inout float aC,  // Accumulated color, with negative lobe.
	inout float aW, // Accumulated weight.
	vec2 off,       // Pixel offset from resolve position to tap.
	vec2 dir,       // Gradient direction.
	vec2 len,       // Length.
	float lob,      // Negative lobe strength.
	float clp,      // Clipping point.
	float c){        // Tap color.
	// Rotate offset by direction.
	vec2 v;
	v.x = (off.x * ( dir.x)) + (off.y * dir.y);
	v.y = (off.x * (-dir.y)) + (off.y * dir.x);
	// Anisotropy.
	v *= len;
	// Compute distance^2.
	float d2 = v.x * v.x + v.y * v.y;
	// Limit to the window as at corner, 2 taps can easily be outside.
	d2 = min(d2, clp);
	// Approximation of lancos2 without sin() or rcp(), or sqrt() to get x.
	//  (25/16 * (2/5 * x^2 - 1)^2 - (25/16 - 1)) * (1/4 * x^2 - 1)^2
	//  |_______________________________________|   |_______________|
	//                   base                             window
	// The general form of the 'base' is,
	//  (a*(b*x^2-1)^2-(a-1))
	// Where 'a=1/(2*b-b^2)' and 'b' moves around the negative lobe.
	float wB = float(2.0 / 5.0) * d2 + float(-1.0);
	float wA = lob * d2 + float(-1.0);
	wB *= wB;
	wA *= wA;
	wB = float(25.0 / 16.0) * wB + float(-(25.0 / 16.0 - 1.0));
	float w = wB * wA;
	// Do weighted average.
	aC += c * w;
	aW += w;
}

// Accumulate direction and length.
void FsrEasuSet(
	inout vec2 dir,
	inout float len,
	vec2 pp,
	bool biS, bool biT, bool biU, bool biV,
	float lA, float lB, float lC, float lD, float lE){
	// Compute bilinear weight, branches factor out as predicates are compiler time immediates.
	//  s t
	//  u v
	float w = float(0.0);
	if(biS) w = (float(1.0) - pp.x) * (float(1.0) - pp.y);
	if(biT) w = pp.x * (float(1.0) - pp.y);
	if(biU) w = (float(1.0) - pp.x) * pp.y;
	if(biV) w = pp.x * pp.y;
	// Direction is the '+' diff.
	//    a
	//  b c d
	//    e
	// Then takes magnitude from abs average of both sides of 'c'.
	// Length converts gradient reversal to 0, smoothly to non-reversal at 1, shaped, then adding horz and vert terms.
	float dc = lD - lC;
	float cb = lC - lB;
	float lenX = max(abs(dc), abs(cb));
	lenX = APrxLoRcpF1(lenX);
	float dirX = lD - lB;
	dir.x += dirX * w;
	lenX = clamp(abs(dirX) * lenX, float(0.0), float(1.0));
	lenX *= lenX;
	len += lenX * w;
	// Repeat for the y axis.
	float ec = lE - lC;
	float ca = lC - lA;
	float lenY = max(abs(ec), abs(ca));
	lenY = APrxLoRcpF1(lenY);
	float dirY = lE - lA;
	dir.y += dirY * w;
	lenY = clamp(abs(dirY) * lenY, float(0.0), float(1.0));
	lenY *= lenY;
	len += lenY * w;
}

vec4 hook() {
	//------------------------------------------------------------------------------------------------------------------------------
	// Get position of 'f'.
	vec2 pp = HOOKED_pos * HOOKED_size - vec2(0.5);
	vec2 fp = floor(pp);
	pp -= fp;
	//------------------------------------------------------------------------------------------------------------------------------
	// 12-tap kernel.
	//    b c
	//  e f g h
	//  i j k l
	//    n o
	// Gather 4 ordering.
	//  a b
	//  r g
	// For packed FP16, need either {rg} or {ab} so using the following setup for gather in all versions,
	//    a b    <- unused (z)
	//    r g
	//  a b a b
	//  r g r g
	//    a b
	//    r g    <- unused (z)
	// Allowing dead-code removal to remove the 'z's.
	
 #if (defined(HOOKED_gather) && (__VERSION__ >= 400 || (GL_ES && __VERSION__ >= 310)))
	vec4 bczzL = HOOKED_gather(vec2((fp + vec2(1.0, -1.0)) * HOOKED_pt), 0);
	vec4 ijfeL = HOOKED_gather(vec2((fp + vec2(0.0,  1.0)) * HOOKED_pt), 0);
	vec4 klhgL = HOOKED_gather(vec2((fp + vec2(2.0,  1.0)) * HOOKED_pt), 0);
	vec4 zzonL = HOOKED_gather(vec2((fp + vec2(1.0,  3.0)) * HOOKED_pt), 0);
#else
	// pre-OpenGL 4.0 compatibility
	float b = HOOKED_tex(vec2((fp + vec2(0.5, -0.5)) * HOOKED_pt)).r;
	float c = HOOKED_tex(vec2((fp + vec2(1.5, -0.5)) * HOOKED_pt)).r;
	
	float e = HOOKED_tex(vec2((fp + vec2(-0.5, 0.5)) * HOOKED_pt)).r;
	float f = HOOKED_tex(vec2((fp + vec2( 0.5, 0.5)) * HOOKED_pt)).r;
	float g = HOOKED_tex(vec2((fp + vec2( 1.5, 0.5)) * HOOKED_pt)).r;
	float h = HOOKED_tex(vec2((fp + vec2( 2.5, 0.5)) * HOOKED_pt)).r;
	
	float i = HOOKED_tex(vec2((fp + vec2(-0.5, 1.5)) * HOOKED_pt)).r;
	float j = HOOKED_tex(vec2((fp + vec2( 0.5, 1.5)) * HOOKED_pt)).r;
	float k = HOOKED_tex(vec2((fp + vec2( 1.5, 1.5)) * HOOKED_pt)).r;
	float l = HOOKED_tex(vec2((fp + vec2( 2.5, 1.5)) * HOOKED_pt)).r;
	
	float n = HOOKED_tex(vec2((fp + vec2(0.5, 2.5) ) * HOOKED_pt)).r;
	float o = HOOKED_tex(vec2((fp + vec2(1.5, 2.5) ) * HOOKED_pt)).r;

	vec4 bczzL = vec4(b, c, 0.0, 0.0);
	vec4 ijfeL = vec4(i, j, f, e);
	vec4 klhgL = vec4(k, l, h, g);
	vec4 zzonL = vec4(0.0, 0.0, o, n);
#endif
	//------------------------------------------------------------------------------------------------------------------------------
	// Rename.
	float bL = bczzL.x;
	float cL = bczzL.y;
	float iL = ijfeL.x;
	float jL = ijfeL.y;
	float fL = ijfeL.z;
	float eL = ijfeL.w;
	float kL = klhgL.x;
	float lL = klhgL.y;
	float hL = klhgL.z;
	float gL = klhgL.w;
	float oL = zzonL.z;
	float nL = zzonL.w;
	// Accumulate for bilinear interpolation.
	vec2 dir = vec2(0.0);
	float len = float(0.0);
	FsrEasuSet(dir, len, pp, true, false, false, false, bL, eL, fL, gL, jL);
	FsrEasuSet(dir, len, pp, false, true, false, false, cL, fL, gL, hL, kL);
	FsrEasuSet(dir, len, pp, false, false, true, false, fL, iL, jL, kL, nL);
	FsrEasuSet(dir, len, pp, false, false, false, true, gL, jL, kL, lL, oL);
	//------------------------------------------------------------------------------------------------------------------------------
	// Normalize with approximation, and cleanup close to zero.
	vec2 dir2 = dir * dir;
	float dirR = dir2.x + dir2.y;
	bool zro = dirR < float(1.0 / 32768.0);
	dirR = APrxLoRsqF1(dirR);
	dirR = zro ? float(1.0) : dirR;
	dir.x = zro ? float(1.0) : dir.x;
	dir *= vec2(dirR);
	// Transform from {0 to 2} to {0 to 1} range, and shape with square.
	len = len * float(0.5);
	len *= len;
	// Stretch kernel {1.0 vert|horz, to sqrt(2.0) on diagonal}.
	float stretch = (dir.x * dir.x + dir.y * dir.y) * APrxLoRcpF1(max(abs(dir.x), abs(dir.y)));
	// Anisotropic length after rotation,
	//  x := 1.0 lerp to 'stretch' on edges
	//  y := 1.0 lerp to 2x on edges
	vec2 len2 = vec2(float(1.0) + (stretch - float(1.0)) * len, float(1.0) + float(-0.5) * len);
	// Based on the amount of 'edge',
	// the window shifts from +/-{sqrt(2.0) to slightly beyond 2.0}.
	float lob = float(0.5) + float((1.0 / 4.0 - 0.04) - 0.5) * len;
	// Set distance^2 clipping point to the end of the adjustable window.
	float clp = APrxLoRcpF1(lob);
	//------------------------------------------------------------------------------------------------------------------------------
	// Accumulation mixed with min/max of 4 nearest.
	//    b c
	//  e f g h
	//  i j k l
	//    n o
	float min1 = min(AMin3F1(fL, gL, jL), kL);
	float max1 = max(AMax3F1(fL, gL, jL), kL);

	// Accumulation.
	float aC = 0.0;
	float aW = float(0.0);
	FsrEasuTap(aC, aW, vec2( 0.0,-1.0) - pp, dir, len2, lob, clp, bL); // b
	FsrEasuTap(aC, aW, vec2( 1.0,-1.0) - pp, dir, len2, lob, clp, cL); // c
	FsrEasuTap(aC, aW, vec2(-1.0, 1.0) - pp, dir, len2, lob, clp, iL); // i
	FsrEasuTap(aC, aW, vec2( 0.0, 1.0) - pp, dir, len2, lob, clp, jL); // j
	FsrEasuTap(aC, aW, vec2( 0.0, 0.0) - pp, dir, len2, lob, clp, fL); // f
	FsrEasuTap(aC, aW, vec2(-1.0, 0.0) - pp, dir, len2, lob, clp, eL); // e
	FsrEasuTap(aC, aW, vec2( 1.0, 1.0) - pp, dir, len2, lob, clp, kL); // k
	FsrEasuTap(aC, aW, vec2( 2.0, 1.0) - pp, dir, len2, lob, clp, lL); // l
	FsrEasuTap(aC, aW, vec2( 2.0, 0.0) - pp, dir, len2, lob, clp, hL); // h
	FsrEasuTap(aC, aW, vec2( 1.0, 0.0) - pp, dir, len2, lob, clp, gL); // g
	FsrEasuTap(aC, aW, vec2( 1.0, 2.0) - pp, dir, len2, lob, clp, oL); // o
	FsrEasuTap(aC, aW, vec2( 0.0, 2.0) - pp, dir, len2, lob, clp, nL); // n
	//------------------------------------------------------------------------------------------------------------------------------
	// Normalize and dering.
	vec4 pix = vec4(0.0, 0.0, 0.0, 1.0);
	pix.r = min(max1, max(min1, aC * float(1.0 / aW)));

	return pix;
}

//!HOOK LUMA
//!BIND EASUTEX
//!DESC FidelityFX Super Resolution 1.0 (RCAS)
//!WIDTH EASUTEX.w
//!HEIGHT EASUTEX.h
//!COMPONENTS 1

// User variables - RCAS
#define SHARPNESS 0.25 // Controls the amount of sharpening. The scale is {0.0 := maximum, to N>0, where N is the number of stops (halving) of the reduction of sharpness}. 0.0 to N>0.
#define FSR_RCAS_DENOISE 1 // If set to 1, applies denoising in addition to sharpening. Can be disabled for better performance. 0 or 1.

// Shader code

#define FSR_RCAS_LIMIT (0.25 - (1.0 / 16.0)) // This is set at the limit of providing unnatural results for sharpening.

float APrxMedRcpF1(float a) {
	float b = uintBitsToFloat(uint(0x7ef19fff) - floatBitsToUint(a));
	return b * (-b * a + float(2.0));
}

float AMax3F1(float x, float y, float z) {
	return max(x, max(y, z)); 
}

float AMin3F1(float x, float y, float z) {
	return min(x, min(y, z));
}

vec4 hook() {
	// Algorithm uses minimal 3x3 pixel neighborhood.
	//    b 
	//  d e f
	//    h
#if (defined(EASUTEX_gather) && (__VERSION__ >= 400 || (GL_ES && __VERSION__ >= 310)))
	vec3 bde = EASUTEX_gather(EASUTEX_pos + EASUTEX_pt * vec2(-0.5), 0).xyz;
	float b = bde.z;
	float d = bde.x;
	float e = bde.y;

	vec2 fh = EASUTEX_gather(EASUTEX_pos + EASUTEX_pt * vec2(0.5), 0).zx;
	float f = fh.x;
	float h = fh.y;
#else
	float b = EASUTEX_texOff(vec2( 0.0, -1.0)).r;
	float d = EASUTEX_texOff(vec2(-1.0,  0.0)).r;
	float e = EASUTEX_tex(EASUTEX_pos).r;
	float f = EASUTEX_texOff(vec2(1.0, 0.0)).r;
	float h = EASUTEX_texOff(vec2(0.0, 1.0)).r;
#endif

	// Min and max of ring.
	float mn1L = min(AMin3F1(b, d, f), h);
	float mx1L = max(AMax3F1(b, d, f), h);

	// Immediate constants for peak range.
	vec2 peakC = vec2(1.0, -1.0 * 4.0);

	// Limiters, these need to be high precision RCPs.
	float hitMinL = min(mn1L, e) * (float(1.0) / (float(4.0) * mx1L));
	float hitMaxL = (peakC.x - max(mx1L, e)) * (float(1.0) / (float(4.0) * mn1L + peakC.y));
	float lobeL = max(-hitMinL, hitMaxL);
	float lobe = max(float(-FSR_RCAS_LIMIT), min(lobeL, float(0.0))) * exp2(-max(float(SHARPNESS), float(0.0)));

	// Apply noise removal.
#if (FSR_RCAS_DENOISE == 1)
	// Noise detection.
	float nz = float(0.25) * b + float(0.25) * d + float(0.25) * f + float(0.25) * h - e;
	nz = clamp(abs(nz) * APrxMedRcpF1(AMax3F1(AMax3F1(b, d, e), f, h) - AMin3F1(AMin3F1(b, d, e), f, h)), 0.0, 1.0);
	nz = float(-0.5) * nz + float(1.0);
	lobe *= nz;
#endif

	// Resolve, which needs the medium precision rcp approximation to avoid visible tonality changes.
	float rcpL = APrxMedRcpF1(float(4.0) * lobe + float(1.0));
	vec4 pix = vec4(0.0, 0.0, 0.0, 1.0);
	pix.r = float((lobe * b + lobe * d + lobe * h + lobe * f + e) * rcpL);

	return pix;
}