use context starter2024

# PROBLEM 1
# Design a function to determine if a given year is a leap year. The function should return true if the year is a leap year, otherwise false.


fun leap-year(year ::  Number) -> Boolean:
  doc: "determines if a given year is a leap year"
  ask: 
    | num-modulo(year, 4) == 0 then: true
    | (num-modulo(year, 100) == 0) and (num-modulo(year, 400) == 0) then: true
    | otherwise: false
  end
where:
  leap-year(2024) is true
  leap-year(2020) is true
  leap-year(2025) is false
end


## PROBLEM 2
# Design a function tick, that takes a number of seconds and returns the next second, as if a clock were ticking. Be sure that it does the right thing if given 59 seconds is input! Be sure to include a doc string and test cases in a where block.

fun ticking(second :: Number) -> Number:
  doc: "returns the next second"
  if second < 59:
    second + 1
    else:
    0
  end
where:
  ticking(47) is 48
  ticking(59) is 0
end


### PROBLEM 3
#| Design a function called rock-paper-scissors that can determine the winner of a Rock, paper, scissorsLinks to an external site. game.

The function should take two inputs representing the choices of two players
Return either the string "player 1" or "player 2" to indicate the winner or "tie" when the game has tied
Each player input should be one of the following the strings: "rock", "paper" and "scissors"
Return the string "invalid choice" if the input is not valid
|#

fun rock-paper-scissors(
    player1 :: String,
    player2 :: String) -> String:
  doc: "determines the winner of rock-paper-scissors"
  ask:
      ## ROCK & SCISSORS
    | rock-paper-scissors("rock", "scissors") then: "player 1 is the winner"
    | rock-paper-scissors("scissors", "rock") then: "player 2 is the winner"
      # SCISSORS & PAPER
    | rock-paper-scissors("scissors", "paper") then: "player 1 is the winner"
    | rock-paper-scissors("paper", "scissors") then: "player 2 is the winner"
      ##PAPER & ROCK
    | rock-paper-scissors("paper", "rock") then: "player 1 is the winner"
    | rock-paper-scissors("rock", "paper") then: "player 2 is the winner"
      # TIE
    | rock-paper-scissors("rock", "rock") then: "tie"
    | rock-paper-scissors("scissors", "scissors") then: "tie"
    | rock-paper-scissors("paper", "paper") then: "tie"
      # ELSE
    | otherwise: "invalid choice"
  end
where:
  rock-paper-scissors("rock, rock") is "tie"
  rock-paper-scissors("paper", "rock") is "player 1 is the winner"
  rock-paper-scissors("scissors", "rock") is "player 2 is the winner"
  rock-paper-scissors("apple", "rock") is "invaild choice"
end
  