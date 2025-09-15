include image

### 1  T-Shirt Shop


# Calculating Cost: You sell custom T-shirt designs for £12 each. However, each design requires a £3 setup fee.

## Write an expression to calculate the total cost for 5 identical T-shirts for a custom design.

number1 = 5
number2 = 7

cost1 = (number1 * 12) + 3
cost2 = (number2 * 12) + 3


##Write an expression to calculate the total cost for 5 identical T-shirts for a custom design.
"The cost of 5 identical T-shirts for a custom design is: " + num-to-string(cost1)

###Then, write a second expression for 7 identical T-shirts for a design.
"The cost of 7 identical T-shirts for a custom design is: " + num-to-string(cost2)

#Compare the results.
diff = cost2 - cost1

"The difference in cost is: " + num-to-string(diff)

#Rectangular Poster

##You also print posters. A client wants a 420 by 594mm A2 poster. The price is based on the perimeter of the poster times £0.10p.

###First, compute the perimeter with an expression (remember perimeter = 2 * (width + height)).
width = 420
height = 594

perimeter = 2 * (width + height)

"The perimeter is: " + num-to-string(perimeter)

##Then, multiply that perimeter by 0.10 to find the cost.

costP = 0.10 * (perimeter)

"The cost of the poster is: " + num-to-string(costP)



### 2. String Suprises

#Saving a Tagline

##Your T-shirt shop's tagline is: "Designs for everyone!"
tagline = "Designs for everyone!"

##Type it into Pyret as a string.
#Now omit one of the quotes and see the error.
tagline


###Fix the error so your string prints correctly.



##Colour Inventory
#You keep track of colours as strings. For instance: "red", "blue", "gold".
"red"
"blue"
"gold"
#What happens if you try to + them (e.g. "red" + "blue")?

"red" + "blue"

##Reflect: + works on both numbers and strings. What happens if you do 1 + "blue"?
# Answer: You cannot combine a number and a string with a +, they have to match





#### 3.  Make a Traffic Light

#Frame:
## Start with a solid black rectangle that is tall and narrow (e.g., rectangle(40, 100, "solid", "black")). This will be the traffic light's body.

rectangle(40, 100, "solid", "black")


##Lights:
## Overlay three coloured circles (red, yellow, green) on top of that rectangle, spaced in a vertical stack.

overlay-align("center", "middle", above(circle(15, "solid", "red"), above(circle(15, "solid", "yellow"), circle(15, "solid", "green"))), rectangle(40, 100, "solid", "black"))


###Challenge:
#Can you add a small rectangular "pole" at the bottom?
##How might you use above or beside to position the pole?

above(overlay-align("center", "middle", above(circle(15, "solid", "red"), above(circle(15, "solid", "yellow"), circle(15, "solid", "green"))), rectangle(40, 100, "solid", "black")) ,rectangle(15, 60, "solid", "black"))


#### 4.  Broken Code Hunt

##Goal: Identify type mismatches or wrong arguments.

##Each of these snippets has an error. Try them in Pyret, read the error message, and fix it.

# Goal: A rectangle with width 50 and height 20, solid black
##rectangle(50, "solid", 20, "black")
###Hint: Check the order and types of arguments that rectangle expects.

##circle(30, solid, "red")
##Hint: The second argument must be a string ("solid" or "outline").
