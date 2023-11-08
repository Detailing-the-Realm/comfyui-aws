cd $main_dir
git clone https://github.com/comfyanonymous/ComfyUI.git
sudo apt install wget git python3 python3-venv build-essential net-tools curl ffmpeg -y

#  Setup ComfyUI
cd $comfyui_dir
# Setup virtual environment for Python
python3 -m venv venv
source venv/bin/activate
python3 -m pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu121  --no-warn-script-location

# Install Comfyui requirements
python3 -m pip install -r requirements.txt  --no-warn-script-location