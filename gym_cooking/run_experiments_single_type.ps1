$levels = @("partial-divider_tl")
# $levels = @("open-divider_tl", "partial-divider_tl", "triple-divider_tl", "triple-divider_t")

$models = @("bd")

$nagents = 3
$base = 080800
$nseed = 20

$jobs = @()
$max_jobs = 3


For ($seed = $base + 1; $seed -le ($base + $nseed); $seed++) {
    $jobs = @()
    foreach ($level in $levels) {
        foreach ($model1 in $models) {
            # $logPathTrue = "./logs/hi-True/hi-True_${level}_agents-${nagents}_seed-${seed}_model1-${model1}_model2-${model1}_model3_${model1}.txt"
            # # $cmdTrue = @("python", "main.py", "--num-agents", $nagents, "--seed", $seed, "--level", $level, "--model1", $model1, "--model2", $model1, "--model3", $model1, "--record", "--hi")
            # # Write-Output "$cmdTrue > $logPathTrue"
            # $jobs += Start-Job -ScriptBlock {
            #     param($nagents, $seed, $level, $model1, $logPath)
            #     & "python main.py --num-agents $nagents --seed $seed --level $level --model1 $model1 --model2 $model1 --model3 $model1 --record --hi" | Out-File -FilePath $logPath
            # } -ArgumentList $nagents, $seed, $level, $model1, $logPathTrue 

            $logPathFalse = "./logs/hi-False/hi-False_${level}_agents-${nagents}_seed-${seed}_model1-${model1}_model2-${model1}_model3_${model1}.txt"
            # $cmdFalse = @("python", "main.py", "--num-agents", $nagents, "--seed", $seed, "--level", $level, "--model1", $model1, "--model2", $model1, "--model3", $model1, "--record")
            # Write-Output "$cmdFalse > $logPathFalse"
            $jobs += Start-ThreadJob -ScriptBlock {
                param($nagents, $seed, $level, $model1, $logPath)
                & python main.py --num-agents $nagents --seed $seed --level $level --model1 $model1 --model2 $model1 --model3 $model1 --record | Out-File -FilePath $logPath
            } -ThrottleLimit $max_jobs -ArgumentList $nagents, $seed, $level, $model1, $logPathFalse 
        }
    }
    # Wait for all jobs for this seed to finish before starting the next seed
}
$jobs | ForEach-Object { Wait-Job $_; Receive-Job $_; Remove-Job $_ }
