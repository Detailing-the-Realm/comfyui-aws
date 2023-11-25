"""."""
import json
from urllib import request
import pandas as pd

CHECKPOINT_TEST = True
LORA_TEST = True
ASCORE_TEST = False
CHECKPOINTS = [
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


def fix_negative(positive_prompt, negative_prompt):
    """."""
    negative_fixed = ""
    if "leather" in positive_prompt and "metal" not in negative_prompt:
        negative_fixed = negative_prompt + ", metal"
    elif "metal" in positive_prompt and "leather" not in negative_prompt:
        negative_fixed = negative_prompt + ", leather"
    return negative_fixed


def set_row_data(input_data, data_to_update):
    """."""

    # Update the dictionary
    data_to_update["12"]["inputs"]["ckpt_name"] = (
        input_data["checkpoint"].strip() + ".safetensors"
    )
    print(data_to_update["12"]["inputs"]["ckpt_name"])
    data_to_update["12"]["inputs"]["positive_ascore"] = float(
        input_data["positive_ascore"]
    )
    data_to_update["12"]["inputs"]["negative_ascore"] = float(
        input_data["negative_ascore"]
    )
    if "vae" in input_data["checkpoint"]:
        data_to_update["12"]["inputs"]["vae_name"] = "Baked VAE"
    else:
        data_to_update["12"]["inputs"]["vae_name"] = "sdxl_vae.safetensors"

    data_to_update["12"]["inputs"]["prompt"] = input_data["positive"]
    data_to_update["12"]["inputs"]["prompt"] = fix_negative(
        input_data["positive"], input_data["negative"]
    )
    data_to_update["157"]["inputs"]["seed"] = int(input_data["noise_seed"])

    data_to_update["233"]["inputs"]["art_style"] = input_data["art_style"]

    # step configuration
    data_to_update["161"]["inputs"]["steps_total"] = int(input_data["steps"])
    data_to_update["161"]["inputs"]["refiner_step"] = int(
        round(input_data["steps"] * 1)
    )
    data_to_update["161"]["inputs"]["cfg"] = float(input_data["cfg"])
    # data_to_update["161"]["inputs"]["sampler_name"] = input_data["sampler_name"]
    # data_to_update["161"]["inputs"]["scheduler"] = input_data["scheduler"]

    # freeu
    # data_to_update["171"]["inputs"]["b1"] = input_data["b1"]
    # data_to_update["171"]["inputs"]["b2"] = input_data["b2"]
    # data_to_update["171"]["inputs"]["s1"] = input_data["s1"]
    # data_to_update["171"]["inputs"]["s2"] = input_data["s2"]

    return data_to_update


def queue_prompt(prompt):
    """."""
    p = {"prompt": prompt}
    prompt_data = json.dumps(p).encode("utf-8")
    req = request.Request("http://sdxl.local:8188/prompt", data=prompt_data)
    request.urlopen(req)


if __name__ == "__main__":
    # Load the JSON data
    with open("workflow_api.json", "r", encoding="utf-8") as file:
        original_data = json.load(file)

    df = pd.read_csv("prompts.csv")

    # Loop through all rows in the DataFrame
    for index, row in df.iterrows():
        print(index)
        data = (
            original_data.copy()
        )  # Make a copy of the original data to ensure you're not overwriting changes
        if pd.isnull(row["checkpoint"]):
            print("checkpoints")
            for checkpoint in CHECKPOINTS:
                row["checkpoint"] = checkpoint
                # Assign values from the CSV to the variables
                data = set_row_data(row, data)

                # Call queue_prompt
                queue_prompt(data)
        else:
            print("nothing")
            data = set_row_data(row, data)

            # Call queue_prompt
            queue_prompt(data)
