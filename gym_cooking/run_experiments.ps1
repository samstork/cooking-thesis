$levels = @("partial-divider_tl")
# $levels = @("open-divider_tl", "partial-divider_tl", "triple-divider_tl", "triple-divider_t")

$models = @("bd", "greedy")

$nagents = 3
$base = 100
$nseed = 20

$jobs = @()


For ($seed = $base + 1; $seed -le ($base + $nseed); $seed++) {
    $jobs = @()
    foreach ($level in $levels) {
        foreach ($model1 in $models) {
            $logPathTrue = "./logs/hi-True/hi-True_${level}_agents-${nagents}_seed-${seed}_model1-${model1}_model2-${model1}_model3_${model1}.txt"
            $cmdTrue = "python main.py --num-agents $nagents --seed $seed --level $level --model1 $model1 --model2 $model1 --model3 $model1 --record --hi"
            Write-Output "$cmdTrue > $logPathTrue"
            $jobs += Start-Job -ScriptBlock {
                param($cmd, $logPath)
                & $cmd | Out-File -FilePath $logPath
            } -ArgumentList $cmdTrue, $logPathTrue

            $logPathFalse = "./logs/hi-False/hi-False_${level}_agents-${nagents}_seed-${seed}_model1-${model1}_model2-${model1}_model3_${model1}.txt"
            $cmdFalse = "python main.py --num-agents $nagents --seed $seed --level $level --model1 $model1 --model2 $model1 --model3 $model1 --record"
            Write-Output "$cmdFalse > $logPathFalse"
            $jobs += Start-Job -ScriptBlock {
                param($cmd, $logPath)
                & $cmd | Out-File -FilePath $logPath
            } -ArgumentList $cmdFalse, $logPathFalse
        }
    }
    # Wait for all jobs for this seed to finish before starting the next seed
    $jobs | ForEach-Object { Wait-Job $_; Receive-Job $_; Remove-Job $_ }
}