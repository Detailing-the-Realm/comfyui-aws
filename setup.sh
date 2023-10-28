git clone https://github.com/comfyanonymous/ComfyUI.git
sudo sed -i "/#\$nrconf{restart} = 'i';/s/.*/\$nrconf{restart} = 'a';/" /etc/needrestart/needrestart.conf
sudo apt-get update
sudo apt install wget git python3 python3-venv build-essential net-tools curl -y
# install CUDA (from https://developer.nvidia.com/cuda-downloads)
wget https://developer.download.nvidia.com/compute/cuda/12.2.1/local_installers/cuda_12.2.1_535.86.10_linux.run
sudo sh cuda_12.2.1_535.86.10_linux.run --silent
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo apt-get install git-lfs
sudo -u ubuntu git lfs install --skip-smudge
#  Setup ComfyUI
cd ComfyUI
python -m venv venv
source venv/bin/activate
python -m pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu121  --no-warn-script-location

# Install Comfyui requirements
python -m pip -r requirements.txt  --no-warn-script-location

# Download the SD model v2.1 and move it to the SD model directory
cd models/checkpoints
wget https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors
wget https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0/resolve/main/sd_xl_refiner_1.0.safetensors
# Dynavision XL https://civitai.com/models/122606/dynavision-xl-all-in-one-stylized-3d-sfw-and-nsfw-output-no-refiner-needed?modelVersionId=198962
wget https://civitai.com/api/download/models/198962
# DreamShaper XL https://civitai.com/models/112902/dreamshaper-xl10?modelVersionId=126688
wget https://civitai.com/api/download/models/126688
# Juggernaut XL https://civitai.com/models/133005/juggernaut-xl?modelVersionId=198530
wget https://civitai.com/api/download/models/198530
# Crystal Clear XL https://civitai.com/models/122822/crystal-clear-xl
wget https://civitai.com/api/download/models/133832

# Add Loras
cd ../loras
# DnD Lora https://civitai.com/models/134343/dungeons-and-dragons-style-fantasy-lora-xl?modelVersionId=152042
wget https://civitai.com/api/download/models/152042

# Add custom nodes for ultimate workflow https://civitai.com/models/119528/sdxl-comfyui-ultimate-workflow
cd ../custom_nodes
# Install Comfyroll Custom Nodes
git clone https://github.com/RockOfFire/ComfyUI_Comfyroll_CustomNodes.git
# Install ComfyUI Impact Pack
git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git
cd ComfyUI-Impact-Pack
# Install Impact Pack submodules ahead of initial launch
git submodule update --init --recursive
# Install GitPython dependency (needed for next line)
python -m pip install GitPython --no-warn-script-location
# Install Impact Pack dependencies
python install.py
# Go back to custom nodes
cd ..
# Install WAS Node Suite
git clone https://github.com/WASasquatch/was-node-suite-comfyui.git
cd was-node-suite-comfyui

# Install WAS Node Suite dependencies
python -s -m pip install -r requirements.txt --no-warn-script-location

# Change directory to custom_nodes
cd ..

# Install SDXL Prompt Styler
git clone https://github.com/twri/sdxl_prompt_styler.git

# Install Ultimate SD Upscale
git clone https://github.com/ssitu/ComfyUI_UltimateSDUpscale --recursive

# Install Efficiency Nodes
git clone https://github.com/LucianoCirino/efficiency-nodes-comfyui.git

# Install ControlNet Preprocessors
git clone https://github.com/Fannovel16/comfyui_controlnet_aux.git

# Change directory to .\comfyui_controlnet_aux
cd comfyui_controlnet_aux

# Install Python dependencies
python -s -m pip install -r requirements.txt --no-warn-script-location

# Install Addict module as it's not being installed normally
python -m pip install addict --no-warn-script-location

# Change directory back to custom_nodes
cd ..

# Get simpleeval package as it has trouble loading first time
python -m pip install simpleeval --no-warn-script-location

# Download Failfast Extensions
git clone https://github.com/failfa-st/failfast-comfyui-extensions.git

# Download Derfuu Modded Nodes
git clone https://github.com/Derfuu/Derfuu_ComfyUI_ModdedNodes.git

# Download Comfy_MTB Nodes for Face Swap and Restore
git clone https://github.com/melMass/comfy_mtb.git

# Change directory to comfy_mtb
cd comfy_mtb

# Installing MTB depdenencies
python -m pip install requirements-parser --no-warn-script-location

# Installing MTB requirement dependencies
python -m pip install -r reqs_windows.txt --no-warn-script-location

# Installing gfpgan dependency
python -m pip install gfpgan --no-warn-script-location

# Change directory back to custom_nodes
cd ..

# Download RGThree Comfy Nodes
git clone https://github.com/rgthree/rgthree-comfy.git

# Download ComfyUI Manager
git clone https://github.com/ltdrdata/ComfyUI-Manager.git
cd ../models/ultralytics/bbox

# Download face detection models
curl -L https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8n_v2.pt --output face_yolov8n_v2.pt
curl -L https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8n.pt --output face_yolov8n.pt
curl -L https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8s.pt --output face_yolov8s.pt

# Download hand detection models
curl -L https://huggingface.co/Bingsu/adetailer/resolve/main/hand_yolov8n.pt --output hand_yolov8n.pt

# Change directory to .controlnet
cd ../../controlnet

# Download SDXL Canny ControlNet
curl -L https://huggingface.co/stabilityai/control-lora/resolve/main/control-LoRAs-rank256/control-lora-canny-rank256.safetensors --output control-lora-canny-rank256.safetensors

# Download SDXL Depth ControlNet
curl -L https://huggingface.co/stabilityai/control-lora/resolve/main/control-LoRAs-rank256/control-lora-depth-rank256.safetensors --output control-lora-depth-rank256.safetensors

# Download SDXL OpenPose ControlNet
curl -L https://huggingface.co/thibaud/controlnet-openpose-sdxl-1.0/resolve/main/OpenPoseXL2.safetensors --output openpose-sdxl-1.0.safetensors

# Change directory to models
cd ..

# Create face_restore model path
mkdir face_restore

# Change directory to face_restore
cd face_restore

# Download Face Restore GFPGAN model
curl -L https://github.com/TencentARC/GFPGAN/releases/download/v1.3.4/GFPGANv1.4.pth --output GFPGANv1.4.pth

# Change directory to models
cd ..

# Create insightface model path
mkdir insightface

# Change directory to insightface
cd insightface

# Download Face Swap models
curl -L https://github.com/xinntao/facexlib/releases/download/v0.1.0/detection_mobilenet0.25_Final.pth --output detection_mobilenet0.25_Final.pth
curl -L https://github.com/xinntao/facexlib/releases/download/v0.1.0/detection_Resnet50_Final.pth --output detection_Resnet50_Final.pth
curl -L https://huggingface.co/deepinsight/inswapper/resolve/main/inswapper_128.onnx --output inswapper_128.onnx

# change ownership of the web UI so that a regular user can start the server
cd cd /home/ubuntu
sudo chown -R ubuntu:ubuntu ComfyUI/

# start the server as user 'ubuntu'
sudo -u ubuntu nohup bash ComfyUI/webui.sh --listen > log.txt