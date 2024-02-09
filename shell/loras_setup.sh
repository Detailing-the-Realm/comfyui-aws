# Add Loras
cd "${comfyui_dir}/models/loras"
# DnD Lora https://civitai.com/models/134343/dungeons-and-dragons-style-fantasy-lora-xl?modelVersionId=152042
curl -L https://civitai.com/api/download/models/152042 --output dungeons_and_dragons.safetensors &

# Princeps Omnia LoRA https://civitai.com/models/134810/xl-yamers-style-princeps-omnia-lora
curl -L https://civitai.com/api/download/models/173530 --output princeps_omnia.safetensors &

# https://civitai.com/models/195519?modelVersionId=219782
curl -L https://civitai.com/api/download/models/219782 --output lcs_sdxl.safetensors &

# https://civitai.com/models/180569/art-frahm-1950s-pin-up-style-xl
curl -L https://civitai.com/api/download/models/202646 --output 1950_pinup.safetensors &

# https://civitai.com/models/8217/character-art-stylefashion-girl-sdxl-update
curl -L https://civitai.com/api/download/models/129198 --output character.safetensors &

# https://civitai.com/models/122806/fantasy-art-xl
curl -L https://civitai.com/api/download/models/133805 --output fantasy_art.safetensors &