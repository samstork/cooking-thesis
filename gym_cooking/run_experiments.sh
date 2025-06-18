#!/bin/bash

# levels=("full-divider_salad" "partial-divider_salad" "open-divider_salad" "full-divider_tomato" "partial-divider_tomato" "open-divider_tomato" "full-divider_tl" "partial-divider_tl" "open-divider_tl")
levels=("open-divider_tl" "partial-divider_tl" "triple-divider_tl" "triple-divider_t")


# models=("bd" "dc" "fb" "up" "greedy")
models=("bd", "greedy")

nagents=3
nseed=20

models=("bd" "greedy")

nagents=3
base=100
nseed=20

for ((seed=base+1; seed<=base+nseed; seed++)); do
    pids=()
    for level in "${levels[@]}"; do
        for model1 in "${models[@]}"; do
            logPathTrue="./logs/hi-True/hi-True_${level}_agents-${nagents}_seed-${seed}_model1-${model1}_model2-${model1}_model3_${model1}.txt"
            cmdTrue="python main.py --num-agents $nagents --seed $seed --level $level --model1 $model1 --model2 $model1 --model3 $model1 --record --hi"
            echo "$cmdTrue > $logPathTrue"
            $cmdTrue > "$logPathTrue" 2>&1 &
            pids+=($!)

            logPathFalse="./logs/hi-False/hi-False_${level}_agents-${nagents}_seed-${seed}_model1-${model1}_model2-${model1}_model3_${model1}.txt"
            cmdFalse="python main.py --num-agents $nagents --seed $seed --level $level --model1 $model1 --model2 $model1 --model3 $model1 --record"
            echo "$cmdFalse > $logPathFalse"
            $cmdFalse > "$logPathFalse" 2>&1 &
            pids+=($!)
        done
    done
    # Wait for all jobs for this seed to finish before starting the next seed
    for pid in "${pids[@]}"; do
        wait $pid
    done
done