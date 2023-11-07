# Add custom nodes for ultimate workflow https://civitai.com/models/119528/sdxl-comfyui-ultimate-workflow
python3 -m pip install GitPython gfpgan addict simpleeval --no-warn-script-location

cd "${comfyui_dir}/custom_nodes"
# Install Comfyroll Custom Nodes
git clone https://github.com/RockOfFire/ComfyUI_Comfyroll_CustomNodes.git
# Install ComfyUI Impact Pack
git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git
cd ComfyUI-Impact-Pack
# Install Impact Pack submodules ahead of initial launch
git submodule update --init --recursive

# Install Impact Pack dependencies
python3 install.py
# Go back to custom nodes
cd ..
# Install WAS Node Suite
git clone https://github.com/WASasquatch/was-node-suite-comfyui.git
cd was-node-suite-comfyui

# Install WAS Node Suite dependencies
python3 -s -m pip install -r requirements.txt --no-warn-script-location

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
python3 -s -m pip install -r requirements.txt --no-warn-script-location

# Change directory back to custom_nodes
cd ..

# Download Failfast Extensions
git clone https://github.com/failfa-st/failfast-comfyui-extensions.git

# Download Derfuu Modded Nodes
git clone https://github.com/Derfuu/Derfuu_ComfyUI_ModdedNodes.git

# Download Comfy_MTB Nodes for Face Swap and Restore
git clone https://github.com/melMass/comfy_mtb.git

# Change directory to comfy_mtb
cd comfy_mtb

# Installing MTB depdenencies
python3 -m pip install requirements-parser --no-warn-script-location

# Installing MTB requirement dependencies
python3 -m pip install -r requirements.txt --no-warn-script-location

# Change directory back to custom_nodes
cd ..

# Download RGThree Comfy Nodes
git clone https://github.com/rgthree/rgthree-comfy.git

# Download ComfyUI Manager
git clone https://github.com/ltdrdata/ComfyUI-Manager.git
cd "${comfyui_dir}/models/ultralytics/bbox"

# Download face detection models
curl -L https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8n_v2.pt --output face_yolov8n_v2.pt &
curl -L https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8n.pt --output face_yolov8n.pt &
curl -L https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8s.pt --output face_yolov8s.pt &

# Download hand detection models
curl -L https://huggingface.co/Bingsu/adetailer/resolve/main/hand_yolov8n.pt --output hand_yolov8n.pt &

# Change directory to .controlnet
cd ../../controlnet

# Download SDXL Canny ControlNet
curl -L https://huggingface.co/stabilityai/control-lora/resolve/main/control-LoRAs-rank256/control-lora-canny-rank256.safetensors --output control-lora-canny-rank256.safetensors &

# Download SDXL Depth ControlNet
curl -L https://huggingface.co/stabilityai/control-lora/resolve/main/control-LoRAs-rank256/control-lora-depth-rank256.safetensors --output control-lora-depth-rank256.safetensors &

# Download SDXL OpenPose ControlNet
curl -L https://huggingface.co/thibaud/controlnet-openpose-sdxl-1.0/resolve/main/OpenPoseXL2.safetensors --output openpose-sdxl-1.0.safetensors &

# Change directory to models
cd ..

# Create face_restore model path
mkdir face_restore

# Change directory to face_restore
cd face_restore

# Download Face Restore GFPGAN model
curl -L https://github.com/TencentARC/GFPGAN/releases/download/v1.3.4/GFPGANv1.4.pth --output GFPGANv1.4.pth &

# Change directory to models
cd ..

# Create insightface model path
mkdir insightface

# Change directory to insightface
cd insightface

# Download Face Swap models
curl -L https://github.com/xinntao/facexlib/releases/download/v0.1.0/detection_mobilenet0.25_Final.pth --output detection_mobilenet0.25_Final.pth &
curl -L https://github.com/xinntao/facexlib/releases/download/v0.1.0/detection_Resnet50_Final.pth --output detection_Resnet50_Final.pth &
curl -L https://huggingface.co/deepinsight/inswapper/resolve/main/inswapper_128.onnx --output inswapper_128.onnx &