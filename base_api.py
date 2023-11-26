from classes.comfyUIApi import baseComfyUIApi

if __name__ == "__main__":
    comfyui_api = baseComfyUIApi()

    comfyui_api.set_csv_file("prompts.csv")
    comfyui_api.process_csv()
