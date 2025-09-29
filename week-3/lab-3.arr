use context dcic2024
include csv
include data-source


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
    | (player1 == "rock") and (player2 == "scissors") then: "player 1"
    | (player1 == "scissors") and (player2 == "rock") then: "player 2"
      # SCISSORS & PAPER
    | (player1 == "scissors") and (player2 == "paper") then: "player 1"
    | (player1 == "paper") and (player2 == "scissors") then: "player 2"
      ##PAPER & ROCK
    | (player1 == "paper") and (player2 == "rock") then: "player 1"
    | (player1 == "rock") and (player2 == "paper") then: "player 2"
      # TIE
    | player1 == player2 then: "tie"
      # ELSE
    | otherwise: "invalid choice"
  end
where:
  rock-paper-scissors("rock", "rock") is "tie"
  rock-paper-scissors("paper", "rock") is "player 1"
  rock-paper-scissors("scissors", "rock") is "player 2"
  rock-paper-scissors("apple", "rock") is "invalid choice"
end



# PROBLEM 4
## Define a table called planets and the insert the information about planetary distances from the Sun in astronomical units. Ensure that you create a table with type annotations.

planets-table = table: Planet :: String, Distance :: Number
    row: "Mercury", 0.39
    row: "Venus", 0.72
    row: "Earth", 1
    row: "Mars", 1.52
    row: "Jupiter", 5.2
    row: "Saturn", 9.54
    row: "Uranus", 19.2
    row: "Neptune", 30.06
  end
planets-table


mars = planets-table.row-n(3)
mars
mars["Distance"]


## PROBLEM 5
#Upload the above CSV file (extract the CSV file from the .zip file first) inside VS Code in GitHub

#Load the file in Pyret and assign it to a variable named something.

##Use the sanitizer to convert the columns with numeric data into numbers


something = load-table:
  year :: Number,
  day :: Number, 
  month :: String,
  rate :: Number
  source: csv-table-file("boe_rates.csv", default-options)
  sanitize year using num-sanitizer
  sanitize day using num-sanitizer
  sanitize rate using num-sanitizer
end




##Check the total number of rows inside the table using Pyret

num-rows-something = something.length()
num-rows-something

##Find the median rate in the dataset


median(something, "rate")

##Find the mode for the rate

modes(something, "rate")


##Order the rate column in both ascending and descending order to find the maximum and minimum values

ascending-order = something.increasing-by("rate")
ascending-order

descending-order = something.decreasing-by("rate")
descending-order