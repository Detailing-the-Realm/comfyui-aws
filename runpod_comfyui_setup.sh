comfyui_dir="/workspace/ComfyUI"
export comfyui_dir

sudo apt-get update

bash comfyui_setup.sh
bash loras_setup.sh
bash vae_setup.sh

bash ultimate_flow_setup.sh
bash seargesdxl_install.sh