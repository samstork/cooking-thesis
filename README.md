## Installation
These installation steps should be the same regardless of the operating system being used. 
1. This repository is versioned using Conda. Install a Conda distributions of your choice by following the instructions found here: https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html. I personally recommend miniconda. 
2. Navigate to the directory of this repository (the same folder this README file is in).
3. Use the following command to install the environment: `conda env create -f overcooking-gym_env.yml -n overcooking-gym`

## Running Experiments
1. Navigate to the `/gym_cooking` directory in this repository in a terminal window.
2. Activate the conda environment with the command `conda activate overcooking-gym`
3. Run experiments with the command `python main.py --num-agents <number of agents> --level <level name> --model1 <agent 1 model> [optional args]`
### Arguments
There are only three mandatory arguments in the command:
- `--num-agents` specifies how many agents you need to run. There is currently support for a maximum of 4 agents. 
- `--level` specifies which kitchen layout will be used. Must match up with the name of a level defined as a txt in `./gym_cooking/utils/levels`. 
- `--model1...n` specifies the model of each agent in the environment. Must be defined for each agent individually, so if `num-agents` has been set to 2, `model1` and `model2` will need to be defined. The available options are:
	- `bd` - Bayesian Delegation,
	- `greedy` - Greedy,
	- `dc` - Divide and Conquer,
	- `up` - Uniform Priors, and
	- `fb` - Fixed Beliefs
There are multiple optional arguments that can be set. The important ones are
- `--hi` sets the hidden information condition to true
- `--record` records each timestep as an image in ./gym_cooking/misc/game/records
- `--seed` sets the random seed for the episode

For example, to run an experiment with three Bayesian Delegation agents in the Partial Divider Tomato Lettuce kitchen under the hidden information condition, with a seed of 42, and record the timesteps you would use the following command in the ./gym_cooking directory:
`python main.py --num-agents 3 --level partial-divider_tl --model1 bd --model2 bd --model3 bd --hi --seed 42 --record`
