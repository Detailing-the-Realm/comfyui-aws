# Download the SD model v2.1 and move it to the SD model directory
cd "${comfyui_dir}/models/checkpoints"
# Collosus XL https://civitai.com/models/147720?modelVersionId=208476
curl -L https://civitai.com/api/download/models/208476 --output colosus_xl_vae.safetensors &

# DreamShaper XL https://civitai.com/models/112902/dreamshaper-xl10?modelVersionId=126688
curl -L https://civitai.com/api/download/models/126688 --output dreamshaper_xl_refiner.safetensors &

# Juggernaut XL https://civitai.com/models/133005/juggernaut-xl?modelVersionId=198530
# Sampler: DPM++ 2M Karras
# Steps: 30-40
# CFG: 3-9 (3 looks a bit more realistic, but has slightly fewer details)
curl -L https://civitai.com/api/download/models/198530 --output juggernault_xl_refiner_vae.safetensors &

# Crystal Clear XL https://civitai.com/models/122822/crystal-clear-xl
curl -L https://civitai.com/api/download/models/133832 --output crystal_clear_xl_refiner.safetensors &

# Think Diffusion XL https://civitai.com/models/169868/thinkdiffusionxl?modelVersionId=190908
curl -L https://civitai.com/api/download/models/190908 --output think_diffusion_xl.safetensors &

# End Journey XL https://civitai.com/models/123990/endjourney-xl?modelVersionId=136635
curl -L https://civitai.com/api/download/models/136635 --output endjourney_xl_refiner.safetensors &

# Copay Timless XL https://civitai.com/api/download/models/198246?type=Model&format=SafeTensor&size=pruned&fp=fp16
# Steps : 40~60
# CFG : 7~10
# You can also use hiresfix or After Detailer
# Sampling : DPM 3M++ SDE Karass, Euler a or DPM 2M ++ SDE Karass
# Nprompt:
# (worst quality, low quality, illustration, 3d, 2d), open mouth, tooth,ugly face, old face, long neck,
curl -L https://civitai.com/api/download/models/198246 --output timeless_xl.safetensors &

# UNstable Diffusion https://civitai.com/models/84040/sdxl-unstable-diffusers-yamermix?modelVersionId=225259
# Steps: 35-150 (under 30 steps some artifact may appear and/or weird saturation, for ex: images may look more gritty and less colorful).
# Hires Upscaler: 4xUltraSharp
# Hires upscale: The only limit is your GPU (I upscale 2,5 times the base image, 576x1024)

curl -L https://civitai.com/api/download/models/225259 --output unstable_diffusion_vae.safetensors &

#[Lah] Mysterious | SDXL https://civitai.com/models/118441/lah-mysterious-or-sdxl
# CFG scale: 3-9
# Sampling Step: 30-60
# Sampling Method: DPM++ 2M SDE Karras or Euler a
# ADetailer ON

curl -L https://civitai.com/api/download/models/162380 --output mysterious.safetensors &

# https://civitai.com/models/136220/realistic-fantasy-mix-sdxl
curl -L https://civitai.com/api/download/models/200225 --output fantasy_mix.safetensors &

# curl -L  --output .safetensors &