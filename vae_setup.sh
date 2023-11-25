cd "${comfyui_dir}/models/vae"
curl -L https://huggingface.co/stabilityai/sd-vae-ft-mse-original/resolve/main/vae-ft-mse-840000-ema-pruned.ckpt --output vae-ft-mse-840000-ema-pruned.ckpt &

curl -L https://huggingface.co/stabilityai/sdxl-vae/resolve/main/sdxl_vae.safetensors?download=true --output sdxl_vae.safetensors