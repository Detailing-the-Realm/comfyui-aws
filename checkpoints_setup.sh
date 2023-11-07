# Download the SD model v2.1 and move it to the SD model directory
cd "${comfyui_dir}/models/checkpoints"
# Dynavision XL https://civitai.com/models/122606/dynavision-xl-all-in-one-stylized-3d-sfw-and-nsfw-output-no-refiner-needed?modelVersionId=198962
curl -L https://civitai.com/api/download/models/198962 --output DynaVisionXL_Allinone.safetensors &
# DreamShaper XL https://civitai.com/models/112902/dreamshaper-xl10?modelVersionId=126688
curl -L https://civitai.com/api/download/models/126688 --output dreamshaper_xl10.safetensors &
# Juggernaut XL https://civitai.com/models/133005/juggernaut-xl?modelVersionId=198530
curl -L https://civitai.com/api/download/models/198530 --output juggernault_xl.safetensors &
# Crystal Clear XL https://civitai.com/models/122822/crystal-clear-xl
curl -L https://civitai.com/api/download/models/133832 --output crystal_clear_xl.safetensors &