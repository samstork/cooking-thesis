from envs.overcooked_environment import OvercookedEnvironment
from gym.envs import register

print("Wabalabadooo")
register(
    id="gym_cooking:overcookedEnv-v0",
    entry_point="gym_cooking.envs:OvercookedEnvironment",
)
