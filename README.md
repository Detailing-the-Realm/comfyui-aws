# comfyui-aws

Getting ComfyUI working on CloudFormation and AWS

Based off of this article https://towardsdatascience.com/create-your-own-stable-diffusion-ui-on-aws-in-minutes-35480dfcde6a

# Set up

Download AWS console
Clone this repository
Run
aws cloudformation create-stack --stack-name comfyui-stack --template-body file://cloudformation_template.yaml
