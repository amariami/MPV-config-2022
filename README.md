# MPV-config-2022

Read [mpv.io manual stable for stable version, master for experimental version](https://mpv.io/manual/), [MPV wiki](https://github.com/mpv-player/mpv/wiki), [Mpv FAQ](https://github.com/mpv-player/mpv/wiki/FAQ), 

Just an archive. Generally use with [SVP (Smooth Video Project)](https://www.svp-team.com/wiki/FAQ) on Linux (*barebone free license*) and MAC/Windows (*Paid but you could try a trial version*), SVP uses the same [frame interpolation technique](https://en.wikipedia.org/wiki/Motion_interpolation) as available in high-end TVs and projectors (see “TrimensionDNM”, “Motion Plus”, “Motionflow” and others). Though it can be use without SVP.

Might be usefull `--sigmoid-upscaling` `--correct-downscaling=yes` `--linear-downscaling=no`

Don't forget to set rendering device according on your system `--vulkan-device=help` or `--d3d11-adapter-device=help`.

E.g. select "NVIDIA GeForce GTX 1080 Ti" instead of "AMD Radeon(TM) Vega 10 Graphics" for rendering.

`--vulkan-device=NVIDIA GeForce GTX 1080 Ti` or `--d3d11-adapter-device=NVIDIA GeForce GTX 1080 Ti`. 

SHADERS could be use to enable Upscaling like FSR (Fidelity FX Super Resolution) from here.
[FidelityFX FSR by AMD ported to mpv by agyild](https://gist.github.com/agyild/82219c545228d70c5604f865ce0b0ce5)
Another shaders can be download via [User SCRIPT](https://github.com/mpv-player/mpv/wiki/User-Scripts#user-shaders)

some FSR/CAS/NVidia Image Scaling has been changed the parameter to trigger upscaling without limit by specific resolution in [here](https://github.com/amariami/MPV-config-2022/tree/main/shaders)

it can improving startup speed performance but the unused cache files may stick around, you should delete/remove it manually if cache is too much `--gpu-shader-cache-dir=~~\shaders"`

## * Might usable for low-end/entry level device such as Intel-HD, Vega3 or old Radeon HD APU mobile laptop (*not too old*)

`--glsl-shaders="C:~~\mpv\shaders\AMD-CAS-scaled_luma_trc-sRGB.glsl;C:~~\mpv\shaders\ravu-r3-rgb.glsl"` (**Prefered*, not consuming too much resource)

or `--glsl-shaders="~~\shaders\AMD-FSR_PQ 0_(EASU_DERING-1_ANALYS-0_QUIT-EARLY-0)_(RCAS_PQ-0_DENOISE-1).glsl"`

or `--glsl-shaders="~~\shaders\AMD-CAS-scaled_luma_trc-Gamma-2.2.glsl"`

or `--glsl-shaders="~~\shaders\AMD-CAS-luma_trc-sRGB.glsl"`

or `--glsl-shaders="~~\shaders\AMD-FSR_PQ 0_(EASU_DERING-1_ANALYS-0_QUIT-EARLY-0)_(RCAS_PQ-0_DENOISE-1).glsl;~~\shaders\AMD-CAS-rgb_trc-sRGB.glsl"`

or `--glsl-shaders="~~\shaders\ravu-lite-r2.glsl;~~\shaders\ravu-r2-yuv.glsl"`

[see comment](https://gist.github.com/agyild/82219c545228d70c5604f865ce0b0ce5?permalink_comment_id=4072085#gistcomment-4072085) it doesn't hurt performance impact on mobile laptop

or `--glsl-shaders="~~\shaders\NVIDIA-Scaler128_no-HDR"`

or `--glsl-shaders="~~\shaders\NVIDIA-Scaler128_no-HDR;~~\shaders\AMD-CAS-rgb_trc-sRGB"`

or `--glsl-shaders="C:~~\mpv\shaders\NVIDIA-Scaler128_no-HDR.glsl;C:~~\mpv\shaders\ravu-r3-rgb.glsl"` (**Prefered*)

## * Might usable for Mid-end device

`--glsl-shaders="~~\shaders\AMD-FSR_PQ 0_(EASU_DERING-1_ANALYS-0_QUIT-EARLY-0)_(RCAS_PQ-0_DENOISE-1).glsl;~~\shaders\KrigBilateral.glsl;~~\shaders\SSimDownscaler.glsl"`

or `--glsl-shaders="~~\shaders\FSRCNNX_x2_8-0-4-1.glsl;~~\shaders\KrigBilateral.glsl;~~\shaders\SSimDownscaler.glsl"`

or `--glsl-shaders="~~\shaders\FSRCNNX_x2_16-0-4-1.glsl;~~\shaders\KrigBilateral.glsl;~~\shaders\SSimDownscaler.glsl"`

or `--glsl-shaders="~~\shaders\AMD-FSR_PQ 0_(EASU_DERING-1_ANALYS-0_QUIT-EARLY-0)_(RCAS_PQ-0_DENOISE-1).glsl;~~\shaders\AMD-CAS-rgb_trc-sRGB.glsl;~~\shaders\KrigBilateral.glsl;~~\shaders\SSimDownscaler.glsl"`

or `--glsl-shaders="~~\shaders\NVIDIA-Scaler256_no-HDR.glsl;~~\shaders\AMD-CAS-scaled_rgb_trc_sRGB.glsl"` 

 > for performance *(Combined NIS(Nvidia Image Scaling) + AMD FidelityFX CAS(Contrast Adaptive Sharpening) RGB version* it could get better result cause when using Nvidia scaler only, some few parts are supposed blur that become too sharp might unacceptable, while CAS get better texture especially on blur part but not getting a strong line sharpening.

or `--glsl-shaders="~~\shaders\NVIDIA-Scaler256_HDR.glsl;~~\mpv\shaders\ravu-r3-rgb.glsl"`

or `--glsl-shaders="~~\shaders\NVIDIA-Sharpen256_no-HDR.glsl;~~\mpv\shaders\ravu-r3-rgb.glsl"`

## * Might usable for High-end device

`--glsl-shaders="~~\shaders\~~\shaders\AMD-FSR_PQ 0_(EASU_DERING-1_ANALYS-0_QUIT-EARLY-0)_(RCAS_PQ-0_DENOISE-1).glsl;~~\shaders\AMD-CAS-rgb_trc-sRGB.glsl;~~\shaders\KrigBilateral.glsl;~~\shaders\SSimDownscaler.glsl"`

or `--glsl-shaders="~~\shaders\NVIDIA-Scaler256_HDR.glsl;~~\shaders\KrigBilateral.glsl;~~\shaders\AMD-CAS-rgb_trc-sRGB.glsl"`

or `--glsl-shaders="~~\shaders\FSRCNNX_x2_16-0-4-1.glsl;~~\shaders\KrigBilateral.glsl;~~\shaders\SSimDownscaler.glsl;~~\shaders\~~\shaders\AMD-CAS-rgb_trc-sRGB.glsl"`

or `--glsl-shaders="~~\shaders\FSRCNNX_x2_56-16-4-1.glsl;~~\shaders\KrigBilateral.glsl"`

or `--glsl-shaders="~~\shaders\FSRCNN_x2_r1_32-0-2.glsl;~~\shaders\KrigBilateral.glsl;~~\shaders\SSimDownscaler.glsl"`

or `--glsl-shaders="~~\shaders\FSRCNN_x2_r2_32-0-2.glsl;~~\shaders\KrigBilateral.glsl;~~\shaders\SSimDownscaler.glsl;~~\shaders\~~\shaders\AMD-CAS-rgb_trc-sRGB.glsl"`

or `--glsl-shaders="~~\shaders\NVIDIA-Scaler256_HDR.glsl;~~\mpv\shaders\ravu-r3-rgb.glsl"`

or `--glsl-shaders="~~\shaders\NVIDIA-Sharpen256_HDR.glsl;~~\mpv\shaders\ravu-r3-rgb.glsl"`

`--dither-depth=auto` #or manually set 6/8/10/12/14/16 

`--dither=error-diffusion #(fruit|ordered|error-diffusion|no)` see[#9415](https://github.com/mpv-player/mpv/issues/9415) 

`--error-diffusion=sierra-lite #(simple|false-fs|sierra-lite|floyd-steinberg|atkinson|jarvis-judice-ninke|stucki|burkes|sierra-3|sierra-2)`

`~~\` it means set manually folder/location directory.

 > if you don't like writing combination, often to use same shaders into another platform you can combine many shaders into one file .glsl so less writing in mpv.conf. Make sure that shader doesn't conflict with other shaders.

# Quality reduction with hardware decoding
*some device use DXVA-copy for rendering, enable `--hwdec=d3d11va-copy` to trigger D3d11va-copy.*

*vdpau always does RGB conversion in hardware, which does not support newer colorspaces like BT.2020 correctly. However, vdpau doesn't support 10 bit or HDR encodings, so these limitations are unlikely to be relevant.*

*vaapi and d3d11va are safe. Enabling deinterlacing (or simply their respective post-processing filters) will possibly at least reduce color quality by converting the output to a 8 bit format.*

*dxva2 is not safe. It appears to always use BT.601 for forced RGB conversion, but actual behavior depends on the GPU drivers. Some drivers appear to convert to limited range RGB, which gives a faded appearance. In addition to driver-specific behavior, global system settings might affect this additionally. This can give incorrect results even with completely ordinary video sources. see [mpvio manual](https://mpv.io/manual/master/#options-hwdec).*

*All other methods, in particular the copy-back methods (like dxva2-copy etc.) should hopefully be safe, although they can still cause random decoding issues. At the very least, they shouldn't affect the colors of the image.**Otherwise don't mind when you couldn't tell the different dxva2-copy and d3d11va-copy.**

*In general, it's very strongly advised to avoid hardware decoding unless absolutely necessary, i.e. if your CPU is insufficient to decode the file in questions. If you run into any weird decoding issues, frame glitches or discoloration, and you have `--hwdec=...` turned on, the first thing you should try is disabling it.*

*On modern hardware for better performance and stability use `hwdec=...-copy`, If you're not using SVP and you sure using copy-backed could cause performance hit you could use native hwdec e.g. `hwdec=vaapi` or `hwdec=nvenc`*

# load the 3D LUTs created from the ICC profile
[`--icc-profile-auto`](https://mpv.io/manual/master/#options-icc-profile-auto) (**preferred*)

[`--icc-intent=...`](https://mpv.io/manual/master/#options-icc-intent)

[`--icc-force-contrast=... #no|0-1000000|inf`](https://mpv.io/manual/master/#options-icc-force-contrast)

[`--icc-3dlut-size=256x256x256`](https://mpv.io/manual/master/#options-icc-3dlut-size) 
[3DLUT by James Ritson](https://affinityspotlight.com/article/1d-vs-3d-luts/#3d-luts)
Calculation 8*(N). *64x64x64 72x72x72 80x80x80 88x88x88 96x96x96 104x104x104 112x112x112 120x120x120 128x128x128 ... 256x256x256 ... 512x512x512*

[`--scaler-lut-size=10`](https://mpv.io/manual/master/#options-scaler-lut-size)

[`--icc-cache-dir=~~\iccdir`](https://mpv.io/manual/master/#options-icc-cache-dir) #create a new folder to store cache

[`--icc-profile=...`](https://mpv.io/manual/stable/#options-icc-profile)(*Optional*) #I suggested don't use that if your display support ICC by default, it can ruin motion on video playback caused glitch. Except your system doesn't support color management. On Mac or Windows you shouldn't need that, use auto

[`--fbo-format=...`](https://mpv.io/manual/master/#options-fbo-format) #rgb16f, rgb32f, rgba16f, rgba16hf, rgba32f. f means float

[`--d3d11-output-format=...`](https://mpv.io/manual/master/#options-d3d11-output-format) #rgba16f for d3d11

# Deband/Debanding & Grain

Explanation about [Colour Banding](https://iamscum.wordpress.com/_test1/_test2/debanding/), [Film grain/Granularity](https://iamscum.wordpress.com/_test1/_test2/denosingdegraining/). Generally it used for low end PC or not using any shaders while playing 8bit video without applying masking. of course it can be used when using shaders too.

[`--deband=yes`](https://mpv.io/manual/master/#options-deband) #(set to no if you don't need gpu debanding)

[`--deband-iterations=4`](https://mpv.io/manual/master/#options-deband-iterations) #(More = Better quality, but higher GPU cost. Valur more than 4 are ptactically useless). 

Singularity see [#9430](https://github.com/mpv-player/mpv/issues/9430#issuecomment-968109686), [#9479](https://github.com/mpv-player/mpv/issues/9479), [#7521](https://github.com/mpv-player/mpv/issues/7251)

[`--deband-threshold=32`](https://mpv.io/manual/master/#options-deband-threshold) #(More = Less banding, but progressively diminish image details, more detail loss)

[`--deband-range=16`](https://mpv.io/manual/master/#options-deband-range) #((More = Less banding, but higher GPU cost. Increases radius linearly for each iteration. A higher radius will find more gradients, but a lower radius will smooth more aggressively, If you increase the *--deband-iterations*, you should probably decrease this to compensate)

[`--deband-grain=48`](https://mpv.io/manual/master/#options-deband-grain) #(More = Add some extra noise dynamic grain to the image, this significantly helps cover up remaining quantization artifacts)

If don't like grain/noise from your source video you could use static noise shader then set `*--deband-grain=5 #or 0*`, 

[noise by haasn](https://github.com/haasn/gentoo-conf/blob/xor/home/nand/.mpv/shaders/noise.glsl), [noise static by wopian](https://github.com/wopian/mpv-config/blob/master/shaders/noise_static_luma.hook), 

[Film grain1](https://github.com/haasn/gentoo-conf/blob/xor/home/nand/.mpv/shaders/filmgrain.glsl), [Film grain2](https://github.com/haasn/gentoo-conf/blob/xor/home/nand/.mpv/shaders/filmgrain-smooth.glsl) see [#9725](https://github.com/mpv-player/mpv/issues/9725), 

[mpv on reddit](https://www.reddit.com/r/mpv/comments/sws5nk/any_good_shaders_to_deband/), 

Shader by [Tsubajashi](https://github.com/Tsubajashi/mpv-settings)

for Animation 2D [Anime4K](https://github.com/bloc97/Anime4K/blob/master/GLSL_Instructions.md)

# Tone mapping

You could use specifies the algorithm used for tone-mapping images onto the target display.

[`--tone-mapping=...`](https://mpv.io/manual/master/#options-tone-mapping)

[`--tone-mapping-param=...`](https://mpv.io/manual/master/#options-tone-mapping-param)

for HDR see [#5804](https://github.com/mpv-player/mpv/pull/5804) [is:issue HDR in:...](https://github.com/mpv-player/mpv/issues?q=is%3Aissue+HDR+in%3Atitle%2Cbody%2Ccomments), [#8485](https://github.com/mpv-player/mpv/pull/8485), [#9678](https://github.com/mpv-player/mpv/issues/9678)

# Refresh rate frequency

Set display refresh rate only in your native Operating System. not recommended using [`--override-display-fps=...`](https://mpv.io/manual/master/#options-override-display-fps) sometimes it could ruin your video playback causing glitch and looks awful.

Set mpv.conf `--video-sync=display-resample` + `--tscale=oversample`

or ***`--tscale-blur=0.6991556596428412` + `--tscale=box` (_preferred when use `--vo=gpu`_)***

or `--tscale-clamp=0.0` + `--tscale-radius=1.1` #(lower e.g. 0.955 = sharper; higher 1.005 = smooth; 1.0 = smooth; 1.01 =
 smoother; 1.1 might smoother + `--tscale-window=sphinx` #(or "quadric") +`--tscale=box`
 
to get a list use `--tscale=help`, `--scale-window=help`, 

Guide [eXmendiC wordpress](https://iamscum.wordpress.com/guides/videoplayback-guide/mpv-conf/), [kokomins wordpress refresh rate frequency](https://kokomins.wordpress.com/2019/10/26/svp-4-setup-guide-for-smooth-60-fps-anime-playback/#why-should-i-never-set-svp-to-60-fps), [kokomins mpv guide](https://kokomins.wordpress.com/2019/10/14/mpv-config-guide/)

# Interpolation/Smooth motion

Need [`--video-sync=display-...`](https://mpv.io/manual/master/#options-video-sync) to enable MPV built in [interpolation](https://mpv.io/manual/master/#options-interpolation) e.g `--video-sync=display-resample` or `--video-sync=display-vdrop`

Calculation 
24 fps  = 24*(N)
        = 48Hz, 72Hz, 96Hz, 120Hz, 144Hz, ~~168Hz~~, ~~192Hz~~, ~~216Hz~~, 240hz
```     
25 fps = 25*(N)
30 fps = 30*(N)
60 fps = 60*(N)
```
Explanation guide in [here](https://kokomins.wordpress.com/2019/10/26/svp-4-setup-guide-for-smooth-60-fps-anime-playback/#monitor-refresh-rate-extended)

for 25 fps video set [`--video-sync-max-video-change=...`](https://mpv.io/manual/master/#options-video-sync-max-video-change)

### ***Interlaced***
 
 Calculation (N)/1.001
```
24 fps /1.001 = 23.976023976023976023976023976024 x 2
              = 47.952047952047952047952047952048 Hz
              x3 = 71.928071928071928071928071928072 Hz
              
25 fps /1.001 = 24.975024975024975024975024975025 x 2
              = 49.95004995004995004995004995005 Hz

30 fps /1.001 = 29.97002997002997002997002997003 x 2
              = 59.94005994005994005994005994006 Hz

60 fps /1.001 = 59.94005994005994005994005994006 x 1
              = 59.94005994005994005994005994006 Hz

60 fps /1.001 = 59.94005994005994005994005994006 x 2
              = 119.88011988011988011988011988012 Hz
```
 Wait... what the heck? what different 24 fps vs 23.976 fps?
 
[The dumb U.S. broadcasting NTSC (National Television System Committee) History](https://en.wikipedia.org/wiki/NTSC#History)
 
[Interlaced](https://en.wikipedia.org/wiki/Interlaced_video)
 
[PAL (Phase Alternating Line)](https://en.wikipedia.org/wiki/PAL)
 
[SÉCAM](https://en.wikipedia.org/wiki/SECAM)

### ****On low end device 2C/4T CPU or 4C/4T you could use 1 or 2 light-medium shaders at same time.***

### ****MPV only (Without SVP)***

`vo=gpu`, [`gpu-api=...`]()`--interpolation=yes`. Set Display Frequency on your monitor to 59.999/60/72 Hertz etc. You should try by yourself 

for [`vo=gpu-next`](gpu-renderer-options) see [#9427](https://github.com/mpv-player/mpv/issues/9427),[`--interpolation-preserve`](https://mpv.io/manual/master/#options-interpolation-preserve), [`--image-lut=...`](https://mpv.io/manual/master/#options-image-lut),[`--image-lut-type=...`](https://mpv.io/manual/master/#options-image-lut-type), [`--target-colorspace-hint`](https://mpv.io/manual/master/#options-target-colorspace-hint), [`--tone-mapping=... #spline/bt.2446a`](https://mpv.io/manual/master/#options-tone-mapping), [`--inverse-tone-mapping`](https://mpv.io/manual/master/#options-inverse-tone-mapping), [`--tone-mapping-crosstalk=...`](https://mpv.io/manual/master/#options-tone-mapping-crosstalk), [`--tone-mapping-mode=...`](https://mpv.io/manual/master/#options-gamut-mapping-mode), [`--allow-delayed-peak-detect`](https://mpv.io/manual/master/#options-allow-delayed-peak-detect), [`--lut=...`](https://mpv.io/manual/master/#options-lut), [`--lut-type=...`](https://mpv.io/manual/master/#options-lut-type)

### ****MPV with SVP***

`--input-ipc-server=mpvpipe` `--video-sync=display-resample` `--interpolation=yes` or `--interpolation=no` or don't write this ~~(--interpolation)~~ in mpv.conf let mpv do their own. `--input-ipc-server=/tmp/mpvsocket #linux`

1. If your sytem not enough interpolating fps depending on frequency display such as 60Hz or more, you could lowering Display Frequency to 48Hz
2. If your video source higher resolution than your screen, set Reduce Image scaling on "Frame Size" menu. In Alter video frame size block menu Set alter video framesize "Decrease to screen" 
3. Do "framerate conversion to Movie X2" or Fixed Frame rate 48 fps for 24 fps source 
4. Do "framerate conversion to Movie X2" or Fixed Frame rate 60 fps for 30 fps source
5. Not recommending use an interpolation more than 30 fps source video with SVP, sometimes resulting awful motion in 60Hz display, except use high refresh rate display but idk result on fast panning scene. You know what are you doing here.
6. For me mostly no reason using more than doubling frame rate interpolation. `24 x2 = 48fps`, `25 x 2 = 50fps`, `30 x 2 = 60fps`. Except 15 fps could use `15 x 3 = 45fps` cause 15fps video is lack of B frame and P frame

Reference about [B frame and P frame by Anonymous on codecalamity](https://codecalamity.com/hardware-encoding-4k-hdr10-videos/), If you need High Quality rendering use CPU encoding, afaik at this moment GPU encoding are still far in terms of high quality.

7. On Linux system you already know which one is similiar parameter using .vpy script.
8. If still resulting framedrops, decrease Frame size to HD (1280x720) or set manually on "resize e.g. `-12800768`" (1280 x 768 - WXGA)
9. Probably if you resize to HD but your screen is bigger than HD, maybe you need utilize some shaders for upscaling like AMD FSR, AMD CAS/CAS-Scaled, NVIDIA-Scaler/Sharpen, ravu, SSimSuperRes, nnedi3, FSRCNN_x2 and so on. For Chroma you could utilize ravu r3/r4 rgb version, KrigBilateral and so on. Optional add or reduce [--saturation=...](https://mpv.io/manual/master/#options-saturation) or [--contrast=...](https://mpv.io/manual/master/#options-contrast) might be help for TN panel.


### ****Advantage set display frequency to 48 Hertz and lowering display resolution***
1. you can extend battery life and reduce power consuption on mobile device 
2. reduce unnecessary resource in Dekstop PC. If your system is High-End device you could do complicated settings and heavy scripts which is still difficult to achieve when using higher resolution and refresh rate more than 48 Hertz.

### ****On low end device 2C/4T CPU or 4C/4T with SVP the maximum display resolution scale without eating too much resource maybe between WXGA (1280 x 720) up to FHD (1920 x 1080p).***

### ****If your see a significant framedrop with high display resolution try lowering that, make sure still on the same range aspect ratio (e.g 16:9 / 16:10) then set "decrease to screen size" on SVP***

Singularity;
| Width | Height | AR | Known as |  | Width | Height | AR | Known as |
| --- | --- | --- | --- | --- | --- | --- | --- |  --- |
| 3480 | 2160 | 16:9 | UHD |  | 5464 | 3072 | 16:9 |  |
| 3072 | 1728 | 16:9 |  |  | 2732 | 1536 | 16:9 |  |
| 2160 | 1440 | 16:9 | WQHD |  | 1366 | 768 | 16:9 | HD |
| 2048 | 1152 | 16:9 | QWXGA |  | 683 | 384 | 16:9 |  |
| 1920 | 1080 | 16:9 | FHD |  |  |  |  |  |
| 1536 | 864 | 16:9 |  |  | 5440 | 3072 | 16:9 |  |
| 1280 | 720 | 16:9 | WXGA |  | 2720 | 1536 | 16:9 |  |
| 1024 | 576 | 16:9 | PAL |  | 1360  | 768 | 16:9 | HD |
| 960 | 540 | 16:9 |  |  | 680 | 384 | 16:9 |  |
| 768 | 430 | 16:9 |  |  |  |  |  |  |
| 640 | 360 | 16:9 |  |  | 5120 | 3072 | 16:10 |  |
| 512 | 288 | 16:9 |  |  | 2560 | 1536 | 16:10 |  |
| 480 | 270 | 16:9 |  |  | 1280 | 768 | 16:10 | WXGA |
|  |  |  |  |  | 640 | 384 | 16:10 |  |

* [Graphics display resolution](https://en.wikipedia.org/wiki/Graphics_display_resolution)
* [Resultion scale calculator](https://bneijt.nl/pr/resolution-scale-calculator/)
* [Wikipedia common resolution](https://en.wikipedia.org/wiki/List_of_common_resolutions)
* [list of 16:9 resolutions](https://levvvel.com/169-resolutions/)

### ***The best case scenario is running SVP On:***

1. PC Dekstop CPU with i-GPU (integrated GPU) such as Intel-HD/Iris-Xe/Radeon Vega + Discrete/Dedicated Graphic.
2. Mobile laptop with Hybrid Graphic/Dedicated Graphic

Process can run separately so it doesn't overload devices on one side. SVP can use rendering device to i-GPU then do their own, MPV can do decoding to Discrete or Hybrid Graphics. It give headroom for CPU Core to breathe freely. You can see on monitoring system on Linux terminal or MAC activity monitor or Windows task manager/HWiNFO. 

[`AMD Hybrid Graphics`](https://en.wikipedia.org/wiki/AMD_Hybrid_Graphics)
[`Nvidia Optimus prime`](https://en.wikipedia.org/wiki/Nvidia_Optimus)
[#7336](https://github.com/mpv-player/mpv/issues/7336), []()

# Intermezzo: the lowest device i've ever tried.

I don't know why keeping some old devices and didn't yet throw away. The funny thing they're still alive with a few defect. XD

| Manufactured | Product | Fab Process | Core | Thread | TDP | PL1 | PL2 | Base | Boost | L1 | L2 | L3 | L4 | Integrated Graphic | PCI-E | Memory | Unlocked | Dedicated GPU | Decoding | SVP |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| AMD | E-350 | 40nm (TSMC) | 2 | 2 | 18W | N/A | N/A | 1.60GHz | N/A | 64KB + 64KB | 1MB | N/A | N/A | Radeon HD 6310 | 2.0 | DDR3 | N/A | N/A | Yes | Awful |
| AMD | A4-3330MX | 32nm (Global Foundries) | 2 | 2 | 45W | N/A | N/A | 2.30GHz | 2.60GHz | 128KB + 128KB | 1MB | N/A | N/A | Radeon HD 6480G | 2.0 | DDR3L | Yes | N/A | Yes | Possibly SD-WXGA/HD |
| AMD | A8-3500M | 32nm (Global Foundries) | 4 | 4 | 35W | N/A | N/A | 1.50GHz | 2.40GHz | 256KB + 256KB | 4MB | N/A | N/A | Radeon HD 6620G | 2.0 | DDR3L | Yes | N/A | Yes | Yes Possibly FHD |
| Intel | Celeron N2806 | 22nm Intel | 2 | 2 | 4.5W | N/A | N/A | 1.60GHz | 2.00Ghz | 64KB + 48KB | 1MB | N/A | N/A | HD Graphics for Intel Atom Z3700 Series | 2.0 | DDR3L-RS | No | N/A | N/A | Awful |
| Intel | Celeron N5095 | 10nm Intel | 4 | 4 | 15W | 15W | 25W | 2.00GHz | 2.90Ghz |128KB + 128KB | 1.5MB | 4MB | N/A | UHD Graphics | 3.0 | DDR4 | No | N/A | N/A | Possibly SD-WXGA/HD |
| Intel | i3-6006U | 14nm Intel | 2 | 4 | 15W | 15W | 25W | 2.00GHz | N/A | 64KB + 64KB | 512KB | 3MB | N/A | HD Graphics 520 | 3.0 | DDR4 | No | AMD Radeon R5 M430(Hybrid) | Yes | Yes |
- [x] Linux it's hit and miss using propietary or open source driver. I won't make a general recommendation on which to use, but in some specific case a certain driver are better than others.
- [x] Windows 10 in some CPU using DXVA2, D3D11, OpenGL, OpenCL or Vulkan, run flawesly. Windows 7 or 8.1 I didn't test it yet.
- [ ] Mac, sorry I don't have an old Macbook.
- [x] Minimum possibilty at least 25W-35W TDP range on mobile device is 4 Core / 4 Threads with [proper integrated-GPU](https://www.svp-team.com/wiki/GPU_Compatibility) (minimum Intel HD/UHD with 24EU, Iris Xe/Plus, Radeon HD, Radeon R5/R7/R9, Vega 3/5CU/6/6CU/7CU/8/8CU/9/10/11, Radeon 660M/680M) or 2 Core / 4 Threads + dedicated/hybrid-GPU. You should take care about TDP before blindly buying a mobile laptop cause some OEM vendor Limit/Locked the Boost TDP due to thermal issue.
- [x] Celeron N5095 4C/4T. Multithreaded performance almost match Core i3 performance but single core performance and i-GPU still couldn't compete Core i3 caused by their natural design. I see on intel ark release the new [Celeron 7305](https://ark.intel.com/content/www/us/en/ark/products/226264/intel-celeron-processor-7305-8m-cache-1-10-ghz.html) and [Pentium 8505](https://ark.intel.com/content/www/us/en/ark/products/226265/intel-pentium-processor-8505-8m-cache-up-to-4-40-ghz-with-ipu.html) 5 Core / 6 Thread (1 Core with Hyperthread + 4 Core Celeron by nature) with TDP 15W but can Boost up to 55W, finally paired with i-GPU iris Xe Graphic, it took a long almost 1 decade since first [4 core Celeron release](https://ark.intel.com/content/www/us/en/ark/products/76752/intel-celeron-processor-n2910-2m-cache-1-60-ghz.html) that might be usefull for Low-end to Mid-end device get a last longer battery live without sacrifice too much on performance. Indeed Core i3 always more better than Celeron/Pentium.

Otherwise if your [Entry level hardware is a Dekstop PC class level](https://www.svp-team.com/wiki/FAQ#What_are_system_requirements.3F) that shouldn't be a problem

# set Audio Sample Rate (#optional)

To maintaining acceptable hearing experience i suggested using Floating-Point processing instead of Integers. Float (32/32 bits) @ 96000Hz/192000hz before reaching to output speaker. [32bit Float Explained](https://www.sounddevices.com/32-bit-float-files-explained/), [IEEE 754](https://en.wikipedia.org/wiki/IEEE_754)

***Don't confuse Sample rate/Sampling rate in audio recording/mastering/converting files vs Oversampling on digital to analog signaling***, that's different. Oversampling is a technique upsampling based on the original source (sample rate) to reconstruct signal to reduce audio artifacts distortion and reduce aliasing in Nyquist frequency. Higher levels of oversampling results in less aliasing occurring in the audible range. 

Sounds like i talking bias right because you couldn't tell the different 44100Hz/48000Hz vs 176400Hz/192000Hz? Human hearings limited to 20000Hz? That's not completely true. It's about in-machine processing not the limitation of human audible frequency range, we can't hear or playing digital audio format like you eating a banana because we don't live in virtual world. If we live in cyberspace and limitations as human in general still exist it's possible high frequency can hurt our ears. But we live in different world that's why we need machine as translator that might be complicated. 

Since most audio format on video are stereo lossy format due to less storage and bandwith consumption, we deal with some noise artifact still on acceptable audible range, we could do a trick using phase rotation [Phase rotation by Izotope](http://downloads.izotope.com/docs/rx6/49-phase/index.html#visual-example-of-phase-rotation).

e.g. [ffmpeg audio filter Stereotools](https://ffmpeg.org/ffmpeg-filters.html#stereotools) allow rotation from 0° Degree to 360° Degress or up to your preference.
Theoritically -180° are same to 360° and +180° are same to 180°.

`--af=[stereotools=phasel=true:phaser=true:phase=180:mode=lr>rl]`

`--af=[stereotools=phasel=true:phaser=true:phase=360:mode=lr>lr]`

[ffmpeg audio filter Bass](https://ffmpeg.org/ffmpeg-filters.html#bass_002c-lowshelf)

`--af=[bass=frequency=200:width_type=q:width=2.0:poles=2:gain=16:mix=1:normalize=true:transform=svf:precision=f64]`

[ffmpeg audio filter Firequalizer](https://ffmpeg.org/ffmpeg-filters.html#firequalizer)

`--af=[firequalizer=gain='gain_interpolate(f)':delay=0.027:accuracy=1:wfunc=bharris:gain_entry='entry(50,5.0);entry(100,5.0)':scale=linlin]`

`--af=[firequalizer=gain='gain_interpolate(f)':delay=0.027:accuracy=1:wfunc=bharris:gain_entry='entry(31,5.0);entry(40,5.0);entry(41,5.0);entry(50,5.0);entry(100,5.0);entry(200,5.0);entry(392,5.0);entry(523,5.0)':scale=linlog]`

see [--af=help](https://mpv.io/manual/master/#audio-filters-af)

try using other filter [FFmpeg audio filter](https://ffmpeg.org/ffmpeg-filters.html#Audio-Filters)

* Linux 
<pre> set sample format to
 f32le           PCM 32-bit floating-point little-endian (*preferred)
 f64le           PCM 64-bit floating-point little-endian (*preferred)
 f32be           PCM 32-bit floating-point big-endian
 f64be           PCM 64-bit floating-point big-endian
 
 Sample rate/Sampling rate to 192000 Hz
</pre>

* Windows
<pre>Speaker/Headphones in sound Setting
Default format set to 24bit, 192000Hz (Studio Quality) </pre>

* [Mac](https://support.apple.com/en-us/HT202730) 
<pre>Use this device for sound output
Select a sample rate to 176400.0 Hz or 192000.0 Hz
</pre>

Commonly used sample rate, Sampling rate*(n)
| Common | sample rate |  | Uncommon | sample rate |
| --- | --- | --- | --- | --- |
| 44100Hz | 48000Hz |  | 220500Hz | 240000Hz |
| 88200Hz | 96000Hz |  | 26400Hz | 280600Hz |
| 132300Hz | 144000Hz |  | 308700Hz | 336000Hz |
| 176400Hz | 192000Hz |  | 352800Hz | 384000Hz |
|  |  |  | 396900Hz | 432000Hz |
|  |  |  | 308700Hz | 336000Hz |
|  |  |  | 441000Hz | 480000Hz |
|  |  |  | 485100Hz | 528000Hz |
|  |  |  | 529200Hz | 576000Hz |
|  |  |  | 573300Hz | 624000Hz |
|  |  |  | 617400Hz | 672000Hz |
|  |  |  | 661500Hz | 720000Hz |
|  |  |  | 705600Hz | 768000Hz |
|  |  |  | 749700Hz | 816000Hz |
|  |  |  | 793800Hz | 864000Hz |
|  |  |  | 837900Hz | 912000Hz |
|  |  |  | 882000Hz | 960000Hz |

If your audio hardware in your system doesn't support high sample rate audio produce crackling noise (e.g. poor/old built in internal DAC/Speaker), you could use a capable third-party digital audio interface (Headset/DAC/Speaker).

# miscellaneous

To be clear I'm not a fan of narcissistic audiophile (audiophilaceboo, audiofools). Here's a [nice topic](https://www.ecoustics.com/video/audiophiles-listen/)

CD Quality standard is 441000Hz that's more than enough? Why CD still using 441000Hz? because of compatibility less complicated, cheap. The old audio portable and old sound system device might couldn't process more than 16bits 44100Hz due to algorithm limitation on the hardware side. Did you know the old vinyl? there's still leaving a noise frequency artifact.

Look at [this](http://src.infinitewave.ca/), an example 96Khz files compress to 44.1Khz, select converter to FFmpeg 4.2.2 (soxr) vs FFmpeg 4.2.2 (swr), test result select to sweep. you can look the artifact wave caused by compression in there. Of course compression/lossy reduce audio quality better using lossless right? absolutely not the goal is for less storage and still on acceptable audible range of human ear. (uhh I said twice)

Advantage using 48 kHz sample rate;
   - offers slightly more headroom for tweaking
   - when computer performs processing digital source into sound, generally there's a signal lost (wired/wireless connection) before reaches to the output (speaker). The goal is to reduce effect of signal degradation.
   - reduce aliasing to prevent filter aplied caused by clipping.
   - make it possible to capture inaudible sound into audible. Need prove? You could try recording a sound from electronic cleaning machine called "ultrasonic cleaner" with your gadget.
   - reduce audio distortion effect caused by compression in cloud sharing server down to 44100Hz (if server perfoms compression to reduce bandwith)

I listening music on streaming service like Amazon, Spotify and  Youtube Music. The Offline (When i'm not connecting to the internet) audio or video files are in stereo lossy format such as Opus (afaik google get better implementation in that) and AAC-LC (most streaming music use that), (i'am not a fan of MP3 anymore it's old, don't like exhale/HE-AAC it cause clipping), e.g. use software called "Spek - Acoustic Spectrum Analyzer" On AAC-LC using FFmpeg 44.1KHz cut Frequency up to 20KHz, while Opus 48KHz cut frequency up to 24KHz, so there's some headroom using 48KHz sample rate as final product.

This is a modern day, we don't go back to the past, we learn from the past. I don't have old school audio equiptment anymore.
48KHz is a standard for video. I hope you could agree with that.

reference
* [Nyquist frequency](https://en.wikipedia.org/wiki/Nyquist_frequency)
* [Oversampling in Digital Audio by Philip Mantione](https://theproaudiofiles.com/oversampling/)
* [Nyquist–Shannon sampling theorem](https://en.wikipedia.org/wiki/Nyquist%E2%80%93Shannon_sampling_theorem)
* [Upsampling vs. Oversampling for Digital Audio](https://www.audioholics.com/audio-technologies/upsampling-vs-oversampling-for-digital-audio)
* [bit depth vs sample rate](https://homestudiobasics.com/bit-depth-vs-sample-rate-made-simple/)
* [Digital Audio Basics: Audio Sample Rate and Bit Depth by Griffin Brown](https://www.izotope.com/en/learn/digital-audio-basics-sample-rate-and-bit-depth.html)
* [DSD to PCM Conversion](https://audiopraise.com/services/fpga-cores/dsd-to-pcm-conversion/)
* [Hydrogenaudio Resampling](https://wiki.hydrogenaudio.org/index.php?title=Resampling)
* [Wikipedia 44100Hz](https://en.wikipedia.org/wiki/44,100_Hz#Status)

