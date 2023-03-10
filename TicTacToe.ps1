
$borad = @(

    "[ ]", "[ ]", "[ ]",
    "[ ]", "[ ]", "[ ]",
    "[ ]", "[ ]", "[ ]"
)

cls
$art = "
      _____           _____           _____        
     / ___/__  ___   / ___/__  ___   / ___/__  ___ 
    / /__/ _ \/ _ \ / /__/ _ \/ _ \ / /__/ _ \/ _ \
    \___/\___/\___//___/\___/\___//___/\___/\___/ Tic Tac Toe

    The art was genereate by ChatGPT.
"
$art2 = "
                
                            You win!
                    
                          .-""""""-.
                        .'          '.
                        |   .    .    |
                        |     \__/     |
                         \  \      /  /
                          `'-......-'` 
                             .   .
                             .   .
                
"
$art3 = "
                
                            You lose!
                    
                    
                          .-"""""" -.
                        .'         '.
                        |   .    .   |
                        |      __    |
                         \  \     / /
                          `'-......-'` 
                             .   .
                             .   .
                
"

$art4 = "

                         It´s a tie!

                          .-""""""-.
                       .'            '.
                     .'                '.
                    |     O        O     |
                    |         |            |
                     \      __/         /
                      '-.__..--..__..-'   
                            .   .
                            .   .
                           ..   .. 
"

Write-Host $art

$AI = ""

while ( $true ) {
    $Player = (Read-Host "Choise a player (X or O)").ToUpper()
    if ( $Player -eq "X" ) {
        $AI = "O"
        break
    } elseif ( $Player -eq "O" ) {
        $AI = "X"
        break
    }
}

while ( $true ) {
    cls
    Write-Host $art

    "X", "O" | ForEach-Object {
        if ( (($borad[0] -eq "[$_]") -and ($borad[1] -eq "[$_]") -and ($borad[2] -eq "[$_]")) -or `
             (($borad[3] -eq "[$_]") -and ($borad[4] -eq "[$_]") -and ($borad[5] -eq "[$_]")) -or `
             (($borad[6] -eq "[$_]") -and ($borad[7] -eq "[$_]") -and ($borad[8] -eq "[$_]")) -or `

             (($borad[0] -eq "[$_]") -and ($borad[3] -eq "[$_]") -and ($borad[6] -eq "[$_]")) -or `
             (($borad[1] -eq "[$_]") -and ($borad[4] -eq "[$_]") -and ($borad[7] -eq "[$_]")) -or `
             (($borad[2] -eq "[$_]") -and ($borad[5] -eq "[$_]") -and ($borad[8] -eq "[$_]")) ) {

            if ( $_ -eq "$Player" ) {
                Write-Host $art2
                break
            } else {
                Write-Host $art3
                break
            }
        }
    }

    if ( $borad -notcontains "[ ]" ) {
        
        Write-Host $art4
        break
    }
    
    Write-Host "-------------------"
    Write-Host "| $($borad[0]) | $($borad[1]) | $($borad[2]) |"
    Write-Host "| $($borad[3]) | $($borad[4]) | $($borad[5]) |"
    Write-Host "| $($borad[6]) | $($borad[7]) | $($borad[8]) |"
    Write-Host "-------------------"
    
    $Move = Read-Host "Enter a move (1 - 9)"
    while ( $borad[$Move-1] -ne "[ ]" ) {
        $Move = Read-Host "Enter a move (1 - 9)"
    }

    $borad[$Move-1] = "[$Player]"

    $AI_Move = Get-Random -Maximum 8
    $Count = 0
    while ( $borad[$AI_Move] -ne "[ ]" ) {
        $AI_Move = Get-Random -Maximum 8
        if ( $Count -eq 10 ) {
            $AI_Move = $null
            break
        }
        $Count++
    }

    if ( $AI_Move -ne $null) {
        $borad[$AI_Move] = "[$AI]"
    }
}




