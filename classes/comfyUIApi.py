"""."""
import json
from urllib import request
import pandas as pd


class ComfyUIApi:
    """."""

    def __init__(self):
        """."""
        self.checkpoints = [
            "colossus_xl_vae",
            "crystal_clear_xl",
            "dreamshaper_xl_refiner",
            "endjourney_xl_refiner",
            "juggernault_xl_vae",
            "mysterious",
            "new_reality_xl",
            "protovisionXL_vae",
            "pyro_nsfw_xl",
            "think_difussion_xl",
            "unstable_vae",
        ]

        self.loras = [
            "1950_pinup",
            "character",
            "fantasy_art",
            "forgotten_pages",
            "princeps_omnia_lora",
            "dungeons_and_dragons",
        ]

        self.df = pd.DataFrame()

    def set_api_file(self, api_file: str):
        """."""
        with open(api_file, "r", encoding="utf-8") as file:
            self.original_data = json.load(file)

    def set_csv_file(self, csv_file: str):
        """."""
        self.df = pd.read_csv(csv_file)

    def set_row_data(self, input_data):
        """."""

        self.data = self.original_data

        # Update the dictionary
        self.data["159"]["inputs"]["ckpt_name"] = (
            input_data["checkpoint"].strip() + ".safetensors"
        )
        print(self.data["159"]["inputs"]["ckpt_name"])
        self.data["84"]["inputs"]["positive_ascore"] = float(
            input_data["positive_ascore"]
        )
        self.data["84"]["inputs"]["negative_ascore"] = float(
            input_data["negative_ascore"]
        )
        if "vae" in input_data["checkpoint"]:
            self.data["84"]["inputs"]["vae_name"] = "Baked VAE"
        else:
            self.data["84"]["inputs"]["vae_name"] = "sdxl_vae.safetensors"

        if "refiner" in input_data["checkpoint"]:
            self.data["84"]["inputs"][
                "refiner_ckpt_name"
            ] = "sd_xl_refiner_1.0_0.9vae.safetensors"
            self.data["161"]["inputs"]["refiner_step"] = int(
                round(input_data["steps"] * 0.8)
            )
        else:
            self.data["84"]["inputs"]["refiner_ckpt_name"] = "None"
            self.data["161"]["inputs"]["refiner_step"] = int(input_data["steps"])

        self.data["85"]["inputs"]["lora_name_1"] = (
            input_data["lora"].strip() + ".safetensors"
        )
        print(self.data["85"]["inputs"]["lora_name_1"])
        self.data["154"]["inputs"]["prompt"] = input_data["positive"]
        self.data["89"]["inputs"]["prompt"] = self.fix_negative(
            input_data["positive"], input_data["negative"]
        )
        self.data["205"]["inputs"]["width"] = int(input_data["width"])
        self.data["205"]["inputs"]["height"] = int(input_data["height"])
        self.data["157"]["inputs"]["seed"] = int(input_data["noise_seed"])
        # self.data["31"]["inputs"]["image"] = input_data["pose_image"]

        self.data["233"]["inputs"]["art_style"] = input_data["art_style"]

        # step configuration
        self.data["161"]["inputs"]["steps_total"] = int(input_data["steps"])
        self.data["161"]["inputs"]["cfg"] = float(input_data["cfg"])
        # self.data["161"]["inputs"]["sampler_name"] = input_data["sampler_name"]
        # self.data["161"]["inputs"]["scheduler"] = input_data["scheduler"]

        # freeu
        # self.data["171"]["inputs"]["b1"] = input_data["b1"]
        # self.data["171"]["inputs"]["b2"] = input_data["b2"]
        # self.data["171"]["inputs"]["s1"] = input_data["s1"]
        # self.data["171"]["inputs"]["s2"] = input_data["s2"]

    def fix_negative(self, positive_prompt, negative_prompt):
        """."""
        negative_fixed = ""
        if "leather" in positive_prompt and "metal" not in negative_prompt:
            negative_fixed = negative_prompt + ", metal"
        elif "metal" in positive_prompt and "leather" not in negative_prompt:
            negative_fixed = negative_prompt + ", leather"
        return negative_fixed

    def queue_prompt(self):
        """."""
        p = {"prompt": self.data}
        prompt_data = json.dumps(p).encode("utf-8")
        req = request.Request("http://sdxl.local:8188/prompt", data=prompt_data)
        request.urlopen(req)


class baseComfyUIApi(ComfyUIApi):
    """."""

    def __init__(self):
        super().__init__()
        with open("workflow_api.json", "r", encoding="utf-8") as file:
            self.original_data = json.load(file)

        self.data = self.original_data.copy()

    def process_csv(self):
        """."""

        # Loop through all rows in the DataFrame
        for index, row in self.df.iterrows():
            print(index)
            self.data = (
                self.original_data.copy()
            )  # Make a copy of the original data to ensure you're not overwriting changes
            if pd.isnull(row["checkpoint"]):
                print("checkpoints")
                for checkpoint in self.checkpoints:
                    row["checkpoint"] = checkpoint
                    if pd.isnull(row["lora"]):
                        for lora in self.loras:
                            row["lora"] = lora
                            # Assign values from the CSV to the variables
                            self.set_row_data(row)

                            # Call queue_prompt
                            self.queue_prompt()
                    else:
                        # Assign values from the CSV to the variables
                        self.set_row_data(row)

                        # Call queue_prompt
                        self.queue_prompt()

            elif pd.isnull(row["lora"]):
                print("lora")
                for lora in self.loras:
                    row["lora"] = lora
                    # Assign values from the CSV to the variables
                    self.set_row_data(row)

                    # Call queue_prompt
                    self.queue_prompt()

            else:
                print("nothing")
                self.set_row_data(row)

                # Call queue_prompt
                self.queue_prompt()


class lcmComfyUIApi(ComfyUIApi):
    def __init__(self):
        super().__init__()
        with open("workflow_api_lcm.json", "r", encoding="utf-8") as file:
            self.original_data = json.load(file)

        self.data = self.original_data

    def process_csv(self):
        """."""
        # Loop through all rows in the DataFrame

        for index, row in self.df.iterrows():
            print(index)
            self.data = (
                self.original_data.copy()
            )  # Make a copy of the original data to ensure you're not overwriting changes
            if pd.isnull(row["checkpoint"]):
                print("checkpoints")
                for checkpoint in self.checkpoints:
                    row["checkpoint"] = checkpoint
                    # Assign values from the CSV to the variables
                    self.set_row_data(row)

                    # Call queue_prompt
                    self.queue_prompt()
            else:
                print("nothing")
                self.set_row_data(row)

                # Call queue_prompt
                self.queue_prompt()
