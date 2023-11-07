comfyui_dir="/workspace/ComfyUI"
export comfyui_dir

sudo sed -i "/#\$nrconf{restart} = 'i';/s/.*/\$nrconf{restart} = 'a';/" /etc/needrestart/needrestart.conf
sudo apt-get update

# install CUDA (from https://developer.nvidia.com/cuda-downloads)
wget https://developer.download.nvidia.com/compute/cuda/12.2.1/local_installers/cuda_12.2.1_535.86.10_linux.run
sudo sh cuda_12.2.1_535.86.10_linux.run --silent
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo apt-get install git-lfs
sudo -u ubuntu git lfs install --skip-smudge

bash comfyui_setup.sh
bash loras_setup.sh
bash vae_setup.sh

bash ultimate_flow_setup.sh
bash seargesdxl_install.sh