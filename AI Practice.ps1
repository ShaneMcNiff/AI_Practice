# AI is kind of cool, I'm going to try make a tournament

function fitness_function($parent){
    
    $fitness = 0

    $i = 0
    foreach($i in $parent){
        if($parent[$i] -eq '1'){
            $fitness++
        }
    }

    return $fitness
    
}

function selection (){
    
    $parent1_fitness = 0
    $parent2_fitness = 0

    Write-Host "`nSelection start"
    $parent1_fitness = fitness_function($global:parent1)
    $parent2_fitness = fitness_function($global:parent2)
    Write-Host "Fitness parent 1 : "$parent1_fitness
    Write-Host "Fitness parent 2 : "$parent2_fitness

    if($parent1_fitness -eq 8){
        Write-Host "Best fitness has been found : parent1 : "$global:parent1
    }elseif($parent2_fitness -eq 8){
        Write-Host "Best fitness has been found : parent2 : "$global:parent2
    }

    if($parent1_fitness > $parent2_fitness){
        return $global:parent1
    }elseif($parent2_fitness > $parent1_fitness){
        return $global:parent2
    }else{
        if((Get-Random -Maximum 2) -eq 0){
            return $global:parent1
        }else{
            return $global:parent2
        }
    }
}

function crossover(){
    
    $crossover_point = Get-Random -Maximum $global:parent1.Length
    Write-Host "Crossover point : "$crossover_point
    $i = 0
    for($i -eq 0; $i -lt ($crossover_point+1); $i++){
        
        $temp1 = $global:parent1[$i]
        $temp2 = $global:parent2[$i]
        $global:parent1[$i] = $temp2
        $global:parent2[$i] = $temp1

    }

}

function mutation($parent){

    Write-Host "`nMutation start"

    $gene = Get-Random -Maximum $parent.Length
    if($parent[$gene] -eq '0'){
        $parent[$gene] = 1
    }else{
        $parent[$gene] = 0
    }
    Write-Host "Mutation complete`n"

    return $parent

}

<#---------------------------#>

$global:parent1 = @(0) * 8
$global:parent2 = @(0) * 8
write-host "Parent 1 fitness : "fitness_function($global:parent1)
write-host "Parent 2 fitness : "fitness_function($global:parent2)

$generation_count = Read-Host 'How many generations would you like to make '

$current_run = 0
while($current_run -lt $generation_count){
    Write-Host "`nCrossover start"
    crossover
    Write-Host "Crossover complete`n"
    
    $global:parent1 = mutation(selection)

    Write-Host "Parent 1 : "$global:parent1
    Write-Host "Parent 2 : "$global:parent2

    $current_run++
}