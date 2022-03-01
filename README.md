# MPV-config-2022

Read [mpv.io manual stable for stable version, master for experimental version](https://mpv.io/manual/), [MPV wiki](https://github.com/mpv-player/mpv/wiki), [Mpv FAQ](https://github.com/mpv-player/mpv/wiki/FAQ), 

Just an archive. Generally use with SVP (Smooth Video Project) on Linux (*barebone free license*) and MAC/Windows (*Paid but you could try a trial version*), SVP uses the same [frame interpolation technique](https://en.wikipedia.org/wiki/Motion_interpolation) as available in high-end TVs and projectors (see “TrimensionDNM”, “Motion Plus”, “Motionflow” and others). Though it can be use without SVP.

Might be usefull `--sigmoid-upscaling` `correct-downscaling=yes` `linear-downscaling=no`

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

or `--glsl-shaders="~~~~~~~~~~~\shaders\FSR-LUMA(EASU)PQ_CAS(RGB).glsl"`(*Modified from EASU and CAS RGB*)

[see comment](https://gist.github.com/agyild/82219c545228d70c5604f865ce0b0ce5?permalink_comment_id=4072085#gistcomment-4072085) it doesn't hurt performance impact on mobile laptop

or `--glsl-shaders="~~~~~~~~~~~\shaders\NVScaler.glsl"`

# * Might usable for Mid-end device

`--glsl-shaders="~~~~~~~~~~~\shaders\FSR-LUMA.glsl;~~~~~~~~~~~\shaders\KrigBilateral.glsl;~~~~~~~~~~~\shaders\SSimDownscaler.glsl"`

or `--glsl-shaders="~~~~~~~~~~~\shaders\FSRCNNX_x2_8-0-4-1.glsl;~~~~~~~~~~~\shaders\KrigBilateral.glsl;~~~~~~~~~~~\shaders\SSimDownscaler.glsl"`

or `--glsl-shaders="~~~~~~~~~~~\shaders\FSRCNNX_x2_16-0-4-1.glsl;~~~~~~~~~~~\shaders\KrigBilateral.glsl;~~~~~~~~~~~\shaders\SSimDownscaler.glsl"`

or `--glsl-shaders="~~~~~~~~~~~\shaders\FSR-LUMA(EASU)PQ_CAS(RGB).glsl;~~~~~~~~~~~\shaders\KrigBilateral.glsl;~~~~~~~~~~~\shaders\SSimDownscaler.glsl"`

or `--glsl-shaders="~~~~~~~~~~~\shaders\NVScaler256_CAS-RGB.glsl` 

[`NVScaler128_CAS-RGB.glsl`](https://github.com/amariami/MPV-config-2022/blob/main/shaders/NVScaler128_CAS-RGB.glsl) for performance (*Combined NIS(Nvidia Image Scaling) + FidelityFX CAS(Contrast Adaptive Sharpening) RGB version* it could get better result cause when using NVScaler only some few parts are supposed blur that become too sharp might unacceptable, while CAS get better texture especially on blur part but not getting a strong line sharpening.

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

[`--icc-3dlut-size=256x256x256`](https://mpv.io/manual/master/#options-icc-3dlut-size) 
[3DLUT by James Ritson](https://affinityspotlight.com/article/1d-vs-3d-luts/#3d-luts)
Calculation 8^N. *64x64x64 72x72x72 80x80x80 88x88x88 96x96x96 104x104x104 112x112x112 120x120x120 128x128x128 ... 256x256x256 ... 512x512x512*

[`--scaler-lut-size=10`](https://mpv.io/manual/master/#options-scaler-lut-size)

[`--icc-cache-dir=~~~~~~~~~~~\`](https://mpv.io/manual/master/#options-icc-cache-dir)

# Tone mapping

You could use specifies the algorithm used for tone-mapping images onto the target display.

[`--tone-mapping=...`](https://mpv.io/manual/master/#options-tone-mapping)

[`--tone-mapping-param=...`](https://mpv.io/manual/master/#options-tone-mapping-param)

# Refresh rate frequency

Set display refresh rate only in your native Operating System. not recommended using [`--override-display-fps=...`](https://mpv.io/manual/master/#options-override-display-fps) sometimes it could ruin your video playback causing glitch and looks awful.

Set mpv.conf `--video-sync=display-resample` + `--tscale=oversample`

or `--tscale-blur=0.6991556596428412` + `--tscale=box`

or `--tscale-clamp=0.0` + `--tscale-radius=1.1` #(lower e.g. 0.955 = sharper; higher 1.005 = smooth; 1.0 = smooth; 1.01 =
 smoother; 1.1 might smoother + `--tscale-window=sphinx` #(or "quadric") +`--tscale=box`
 
to get a list use `--tscale=help`, `--scale-window=help`, 

Guide [eXmendiC wordpress](https://iamscum.wordpress.com/guides/videoplayback-guide/mpv-conf/), [kokomins wordpress](https://kokomins.wordpress.com/2019/10/14/mpv-config-guide/)

# Interpolation/Smooth motion

Need [`--video-sync=display-...`](https://mpv.io/manual/master/#options-video-sync) to enable MPV built in [interpolation](https://mpv.io/manual/master/#options-interpolation) e.g `--video-sync=display-resample`

Calculation for 24 fps = 24^N, 25 fps = 25^N, 30 fps = 30^N. Explanation guide in [here](https://kokomins.wordpress.com/2019/10/26/svp-4-setup-guide-for-smooth-60-fps-anime-playback/#monitor-refresh-rate-extended)

for 25 fps video set [`--video-sync-max-video-change=...`](https://mpv.io/manual/master/#options-video-sync-max-video-change)

With SVP set display to 48 Hertz in your PC;
* do "framerate conversion to Movie X2/Fixed Frame rate 48 fps" on 24 fps source 
* or "framerate conversion to Movie X2/Fixed Frame rate 60 fps" on 30 fps source
* for me no reason using more than doubling frame rate interpolation.
* On Linux sytem you already know which one is similiar parameter using .vpy script, `--input-ipc-server=mpvpipe`

Advantage set display frequency to 48 Hertz you can extend battery life, reduce power consumption especially on mobile laptop and reduce too much resource in PC. If your system is High-End device you could do complicated settings and use heavy scripts which is still difficult to achieve when using refresh rate more than 48 Hertz.

`--interpolation=yes` or `--interpolation=no` or don't write this in mpv.conf leaving MPV player do their own
in my case when running MPV Player only without SVP get very good result while using 59.999/60 Hertz display refresh rate.

Of course it could be used for other frequency such as 48 Hertz, 72 Hertz, 96 Hertz, 140 Hertz, 240 Herts and so on. However i can't guarantee if it works correctly or not you should try by yourself.

* With SVP 4 you could increase performance and achieve very good smooth motion interpolation use Image scaling "Decrease to screen size". Select image scaling mode in the "Alter video frame size block" then choose "Decrease to HD" or "Decrease to screen" refresh rate set to 48 Hertz and use `--video-sync=display-resample`. 

* If your screen resolution is FHD (1920 x 1080) and see drop frames or glitch you could lowering display resolution to HD+ (1600 x 900) or WXGA (1360 x 765 / 1366 x 768) or HD (1280x720) to gain more performace make sure still on same display aspect ratio range e.g. 16:9

* If your screen resolution is more than FHD like 2K/QHD (2048 × 1080 / 2560 x 1440) and see drop frames you could lowering display resolution to FHD (1920 x 1080) for gain more performace make sure that still on same display aspect ratio range such as 16:9.
"4K-UHD/DCI-4K (3840 x 2160 / 4096 x 2304)" reduce to "3K/QHD+ (3072 x 1728 / 3200 x 1800)", "3K/QHD+ (3072 x 1728 / 3200 x 1800)" reduce to "2K/QHD (2048 × 1080 / 2560 x 1440)"

[Wikipedia common resolution](https://en.wikipedia.org/wiki/List_of_common_resolutions), [list of 16:9 resolutions](https://levvvel.com/169-resolutions/)

* The best case scenario is running SVP On PC Dekstop CPU with i-GPU (integrated GPU) such as Intel-HD/Iris-Xe/Radeon Vega + Discrete/Dedicated Graphic or Mobile laptop with Hybrid Graphics. Process can run separately so it doesn't overload devices on one side. SVP can use rendering device to i-GPU then do their own, MPV can do decoding to Discrete or Hybrid Graphics. It give headroom for CPU Core to breathe freely. You can see on monitoring system on Linux terminal or MAC activity monitor or Windows task manager/HWiNFO. If doesn't work you could set the Output display using i-GPU connecting HDMI or Display Port into the motherboard instead Discrete/Dedicated GPU.

# Audio Quality

To maintaining good hearing experience i suggested using Floating-Point processing instead of Integers. float (32/32 bits) @ 192000hz (*don't confused it's not same as mastering data*)

[32bit Float Explained](https://www.sounddevices.com/32-bit-float-files-explained/)

*Don't confuse Sample rate in audio recording/mastering/converting files vs Oversampling Rate on digital to analog signaling*, that's different. Oversampling is a technique upsampling based on the original source (sample rate) to reconstruct signal to reduce audio artifacts distortion and reduce aliasing in Nyquist frequency. Higher levels of oversampling results in less aliasing occurring in the audible range. 

* Linux 
<pre> set sample format to
 f32le           PCM 32-bit floating-point little-endian (*prefered)
 f64le           PCM 64-bit floating-point little-endian (*prefered)
 f32be           PCM 32-bit floating-point big-endian
 f64be           PCM 64-bit floating-point big-endian
 
 Sample rate/Sampling rate to 192000 Hz
</pre>

* Windows
<pre>Speaker/Headphones in sound Setting
Default format set to 24bit, 19200Hz (Studio Quality) </pre>

* [Mac](https://support.apple.com/en-us/HT202730) 
<pre>Use this device for sound output
Select a sample rate to 176400.0 Hz or 192000.0 Hz
</pre>

If your audio hardware in your system doesn't support high sample rate audio produce crackling noise (e.g. poor/old built in internal DAC/Speaker), you can use a capable third-party digital audio interface (Headset/DAC/Speaker)

# miscellaneous

Sounds like i talking bias right because you couldn't tell the different 44100Hz/48000Hz vs 176400Hz/192000Hz? Human hearings limited to 20000Hz? That's not completely true. It's about in-machine processing not the human listening experience.

CD Quality standard is 441000Hz that's more than enough? Why CD still using 441000Hz? because of compatibility less complicated, the old audio portable and old sound system device might couldn't process more than 16bits 44100Hz due to algorithm limitation on the hardware side. Did you know the old vinyl? there's still leaving a noise frequency artifact.

Look at [this](http://src.infinitewave.ca/), an example 96Khz files compress to 44.1Khz, select converter to FFmpeg (soxr) vs FFmpeg (swr), test result select to sweep. you can look the artifact wave caused by compression in there. Of course compression/lossy reduce audio quality better using lossless but the goal is for storage and still on acceptable audible range of human ear.

Advantage using 48 kHz sample rate
* offers slightly more headroom for tweaking
* when computer performs processing digital source into sound, generally there's a signal lost (wired/wireless connection) before reaches to the output (speaker). The goal is to reduce effect of signal degradation.
* reduce aliasing to prevent filter aplied caused by clipping.
* make it possible to capture inaudible sound into audible. Need prove? You could try recording a sound from electronic cleaning machine called "ultrasonic cleaner" with your gadget.

I listening music on streaming service like Amazon, Spotify and  Youtube Music. The Offline (When i'm not connecting to the internet) audio or video files are in stereo lossy format such as Opus and AAC-LC, (i'am not a fan of MP3 anymore it's old, don't like exhale/HE-AAC it cause clipping), e.g. use software called "Spek - Acoustic Spectrum Analyzer" On AAC-LC using FFmpeg 441KHz cut Frequency up to 20KHz, while Opus are set to 48KHz cut frequency up to 24KHz, so there's some headroom using 48KHz sample rate as final product.

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

