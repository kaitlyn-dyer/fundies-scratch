use context starter2024

include image
# Function Design Pocess 1

##Write a function to calculate the cost of printing a t-shirt, which can have a message written on it. Each shirt costs £5.00 plus an extra 10p per character printed on it.

##First, write an expression for how you would calculate 4 t-shirts with the message "Go Team!".


shirts-cost-4 = (5 * 4) + (0.10 * string-length("Go Team!"))

shirts-cost-4


##Now make another expression, this time for 7 t-shirts with the message "Hello World"

shirts-cost-7 = (5 * 7) + (0.10 * string-length("Hello World"))

shirts-cost-7


##Are there are numbers that should be definitions? So-called magic numbers that aren't obvious what they mean are always good candidates for creating definitions—do that now (there should be two!).

fun tshirt-cost(numshirt :: Number,
    characters :: String) -> Number:
  doc: "Function to calculate the cost of printing a t-shirt, which can have a message written on it"
  (5 * numshirt) + (0.10 * string-length(characters))
end


##Design Process 2

#|Write a function celsius-to-fahrenheit that takes a takes a temperature in Celsius as input and converts it to Fahrenheit using the formula:

Include a doc string and type annotations, following the process from the last exercise

Write a companion function fahrenheit-to-celsius that does the reverse conversion using the following formula:


Create a check block to test both functions with at least three different temperature values:
Verify that celsius-to-fahrenheit(0) returns 32
Verify that fahrenheit-to-celsius(32) returns 0
Add at least one more test case for each function
|#

# Celsius to Fahrenheit
fun C-to-F(celsius :: Number):
  doc: "temperature in Celsius as input and converts it to Fahrenheit"
  (celsius * (9/5)) + 32
end


# Fahrenheit to Celsius
fun F-to-C(fahrenheit :: Number):
  doc: "temperature in Fahrenheit as input and converts it to Celsius"
  (fahrenheit - 32) * (5/9)
end

##Create a check block to test both functions with at least three different temperature values:

check:
  C-to-F(0) is 32
  F-to-C(32) is 0
end


#| Find one of the images you have created in the last two lectures, and define a new function that produces a variation of the image that can be customised using the arguments to a function.

Copy the code from the original example
First, identify the areas of the image that will be fixed
For each part that you want to change, replace the value with a name for the parameter
Wrap the code around a fun statement with a function name
Add parameters and their types inside the parentheses
Add a doc string
|#


fun three-circles(left :: String,
    middle :: String,
    right :: String,
    radius :: Number) -> Image:
  doc: "image of three customizable circles"
  beside(circle(radius, "solid", left),
      beside(circle(radius, "solid", middle), 
        circle(radius, "solid", right)))
end

