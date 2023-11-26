from classes.comfyUIApi import lcmComfyUIApi

if __name__ == "__main__":
    comfyui_api = lcmComfyUIApi()

    comfyui_api.set_csv_file("lcm_prompts.csv")
    comfyui_api.process_csv()
