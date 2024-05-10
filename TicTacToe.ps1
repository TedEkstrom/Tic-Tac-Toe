
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

    Game by Ted Ekström and the 
    artwork was genereate by ChatGPT.
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

function scoreboard ( $P, $A ) {
   
   if ( $P -lt 10 ) {
         
        $Pp = "       "
        $Ap = "       "
   } else {

        $Pp = "      "
        $Ap = "      "
   }

   Write-Host "
               
               ########################################
               #                                      #
               #           Game score                 #
               #           Player: $($P)$Pp           #
               #           AI:     $($A)$Ap           #
               #                                      #
               ########################################
              
              "
} 

$Continue = $true
$AIScore = 0
$PlayerScore = 0

:game while ( $Continue ) {
   
    Write-Host $art

    $AI = ""
    $Player = ""

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

    :gameplay while ( $true ) {
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
                    $PlayerScore++
                    
                } else {
                    Write-Host $art3
                    $AIScore++
                    
                }
                while ( $true ) {
                    $ContinuePlaying = (Read-Host "Continue playing? (Yes/No)").ToUpper()
                    if ( $ContinuePlaying -eq "YES" ) {
                        $Continue = $true
                        break gameplay
                    } elseif ( $ContinuePlaying -eq "NO" ) {
                        $Continue = $false
                        scoreboard -PlayerScore $PlayerScore -AIScore $AIScore
                        break gameplay
                    }
                }
            }
        }

        if ( $borad -notcontains "[ ]" ) {
        
            Write-Host $art4
            $AIScore++
            $PlayerScore++

            while ( $true ) {
                $ContinuePlaying = (Read-Host "Continue playing? (Yes/No)").ToUpper()
                if ( $ContinuePlaying -eq "YES" ) {
                    $Continue = $true
                    break gameplay
                } elseif ( $ContinuePlaying -eq "NO" ) {
                    $Continue = $false
                    break gameplay
                }
            }
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
}
