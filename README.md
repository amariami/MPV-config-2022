# MPV-config-2022
Just an archive. Generally use with SVP (Smooth Video Project) on Linux and Windows though it can be use without SVP.
Don't forget to set rendering device according on your system `--vulkan-device=help` or `--d3d11-adapter-device=help`. 

E.g. select "NVIDIA GeForce GTX 1080 Ti" instead of "AMD Radeon(TM) Vega 10 Graphics" for rendering.

`--vulkan-device=NVIDIA GeForce GTX 1080 Ti` or `--d3d11-adapter-device=NVIDIA GeForce GTX 1080 Ti`. 

SHADERS could be use to enable Upscaling like FSR (Fidelity FX Super Resolution) from here.
[FidelityFX FSR by AMD ported to mpv by agyild](https://gist.github.com/agyild/82219c545228d70c5604f865ce0b0ce5)
Another shaders can be download via [User SCRIPT](https://github.com/mpv-player/mpv/wiki/User-Scripts#user-shaders)

some FSR/CAS/NVidia Image Scaling has been changed the parameter to trigger upscaling without limit by specific resolution in [here](https://github.com/amariami/MPV-config-2022/tree/main/shaders)

it can improving startup speed performance but the unused cache files may stick around, you should delete/remove it manually if cache is too much `--gpu-shader-cache-dir=~~~~~~~~~~~\shaders"`

# * Might usable for low-end/entry level device such as Intel-HD, Vega3 or old Radeon HD APU mobile laptop (*not too old*)

`--glsl-shaders="~~~~~~~~~~~\shaders\FSR-LUMA.glsl"`

or `--glsl-shaders="~~~~~~~~~~~\shaders\CAS-scaled-LUMA.glsl"`

or `--glsl-shaders="~~~~~~~~~~~\shaders\CAS-LUMA.glsl"`

or `--glsl-shaders="~~~~~~~~~~~\shaders\FSR-LUMA(EASU)PQ_CAS(RGB).glsl"`(*Modified from EASU and CAS RGB*) [see comment](https://gist.github.com/agyild/82219c545228d70c5604f865ce0b0ce5?permalink_comment_id=4072085#gistcomment-4072085) it doesn't hurt performance impact on mobile laptop

or `--glsl-shaders="~~~~~~~~~~~\shaders\NVScaler.glsl"`

# * Might usable for Mid-end device

`--glsl-shaders="~~~~~~~~~~~\shaders\FSR-LUMA.glsl;~~~~~~~~~~~\shaders\KrigBilateral.glsl;~~~~~~~~~~~\shaders\SSimDownscaler.glsl"`

or `--glsl-shaders="~~~~~~~~~~~\shaders\FSRCNNX_x2_8-0-4-1.glsl;~~~~~~~~~~~\shaders\KrigBilateral.glsl;~~~~~~~~~~~\shaders\SSimDownscaler.glsl"`

or `--glsl-shaders="~~~~~~~~~~~\shaders\FSRCNNX_x2_16-0-4-1.glsl;~~~~~~~~~~~\shaders\KrigBilateral.glsl;~~~~~~~~~~~\shaders\SSimDownscaler.glsl"`

or `--glsl-shaders="~~~~~~~~~~~\shaders\FSR-LUMA(EASU)PQ_CAS(RGB).glsl;~~~~~~~~~~~\shaders\KrigBilateral.glsl;~~~~~~~~~~~\shaders\SSimDownscaler.glsl"`

or `--glsl-shaders="~~~~~~~~~~~\shaders\NVScaler256_CAS-RGB.glsl` 
# NVScaler128_CAS-RGB.glsl for performance (*Combined NIS(Nvidia Image Scaling) + FidelityFX CAS(Contrast Adaptive Sharpening) RGB version*. It get better result cause when using NVScaler only some few parts are supposed blur that become too sharp might unacceptable. CAS get better texture especially on blur part but not get strong sharpening.

or `--glsl-shaders="~~~~~~~~~~~\shaders\NVScaler.glsl"`

or `--glsl-shaders="~~~~~~~~~~~\shaders\NVSharpen.glsl"`

# * Might usable for High-end device

`--glsl-shaders="~~~~~~~~~~~\shaders\FSR-LUMA(EASU)PQ_CAS(RGB).glsl;~~~~~~~~~~~\shaders\KrigBilateral.glsl;~~~~~~~~~~~\shaders\SSimDownscaler.glsl;"`

or `--glsl-shaders="~~~~~~~~~~~\shaders\NVScaler256_CAS-RGB.glsl;;~~~~~~~~~~~\shaders\KrigBilateral.glsl;`

or `--glsl-shaders="~~~~~~~~~~~\shaders\FSRCNNX_x2_16-0-4-1.glsl;~~~~~~~~~~~\shaders\KrigBilateral.glsl;~~~~~~~~~~~\shaders\SSimDownscaler.glsl;~~~~~~~~~~~\shaders\CAS-RGB.glsl"`

or `--glsl-shaders="~~~~~~~~~~~\shaders\FSRCNN_x2_r1_32-0-2.glsl;~~~~~~~~~~~\shaders\KrigBilateral.glsl;~~~~~~~~~~~\shaders\SSimDownscaler.glsl"`

or `--glsl-shaders="~~~~~~~~~~~\shaders\FSRCNN_x2_r2_32-0-2.glsl;~~~~~~~~~~~\shaders\KrigBilateral.glsl;~~~~~~~~~~~\shaders\SSimDownscaler.glsl;~~~~~~~~~~~\shaders\CAS-RGB.glsl"`

or `--glsl-shaders="~~~~~~~~~~~\shaders\NVScaler.glsl"`

or `--glsl-shaders="~~~~~~~~~~~\shaders\NVSharpen.glsl"`

`--dither-depth=auto` 

`--dither=error-diffusion #(fruit|ordered|error-diffusion|no)` 

`--error-diffusion=sierra-lite #(simple|false-fs|sierra-lite|floyd-steinberg|atkinson|jarvis-judice-ninke|stucki|burkes|sierra-3|sierra-2)`

`~~~~~~~~~~~\` it means set manually folder/location directory

# Quality reduction with hardware decoding
*some device use DXVA-copy for rendering, enable `--hwdec=d3d11va-copy` to trigger D3d11va-copy.*

*vdpau always does RGB conversion in hardware, which does not support newer colorspaces like BT.2020 correctly. However, vdpau doesn't support 10 bit or HDR encodings, so these limitations are unlikely to be relevant.*

*vaapi and d3d11va are safe. Enabling deinterlacing (or simply their respective post-processing filters) will possibly at least reduce color quality by converting the output to a 8 bit format.*

*dxva2 is not safe. It appears to always use BT.601 for forced RGB conversion, but actual behavior depends on the GPU drivers. Some drivers appear to convert to limited range RGB, which gives a faded appearance. In addition to driver-specific behavior, global system settings might affect this additionally. This can give incorrect results even with completely ordinary video sources. see [mpvio manual](https://mpv.io/manual/master/#options-hwdec).*

*All other methods, in particular the copy-back methods (like dxva2-copy etc.) should hopefully be safe, although they can still cause random decoding issues. At the very least, they shouldn't affect the colors of the image.
Otherwise don't mind when you couldn't tell the different dxva2-copy and d3d11va-copy.*

*In general, it's very strongly advised to avoid hardware decoding unless absolutely necessary, i.e. if your CPU is insufficient to decode the file in questions. If you run into any weird decoding issues, frame glitches or discoloration, and you have `--hwdec=...` turned on, the first thing you should try is disabling it.*

# load the 3D LUTs created from the ICC profile
[`--icc-profile-auto`](https://mpv.io/manual/master/#options-icc-profile-auto)

[`--icc-intent=...`](https://mpv.io/manual/master/#options-icc-intent)

[`--icc-force-contrast=... #no|0-1000000|inf`](https://mpv.io/manual/master/#options-icc-force-contrast)

[`--icc-3dlut-size=256x256x256`#8^N](https://mpv.io/manual/master/#options-icc-3dlut-size) #64x64x64 72x72x72 80x80x80 88x88x88 96x96x96 04x104x104 112x112x112 120x120x120 128x128x128 ... 256x256x256 ... 512x512x512

[`--scaler-lut-size=10`](https://mpv.io/manual/master/#options-scaler-lut-size)

[`--icc-cache-dir=~~~~~~~~~~~\`](https://mpv.io/manual/master/#options-icc-cache-dir)

