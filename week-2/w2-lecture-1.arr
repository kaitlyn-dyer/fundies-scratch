use context starter2024
include image

fill = "solid"

# Define an orange triangle with side length 35. 
side-tri = 35
color-tri = "orange"


orange-tri = triangle(side-tri, fill, color-tri)

#Now evaluate the identifier (i.e., orange-triangle) in the interactions pane.
orange-tri



## Define a side length and colour (as two separate definitions),
side = 40
color = "purple"

##and then define a square using those names for the side length and
purple-square = square(side, fill, color)

#evaluate
purple-square



###Now define a second version where you do not use the side length and colour variables. Notice that when you evaluate both identifiers in the interactions, they are exactly the same, but the code is easier to read with the separate definitions.





##Try defining a new side length with the same variable, later in the definitions. Note what happens when you try to hit "Run". Redefining the same variable is called shadowing, and Pyret rules this out, since it is a common cause of bugs.

#answer: I get an error


########Now define an image that has a small yellow circle on top of a larger black rectangle. Try several different ways, using different number of definitions. See which is easiest to understand.

## RECTANGLE:
w = 100
l = 150
color-rec = "black"

rectangle-big = rectangle(w, l, fill, color-rec)

## CIRCLE:
radius = 30
color-cir = "yellow"

circle-s = circle(radius, fill, color-cir)

## IMAGE:
above(circle-s, rectangle-big)



##Go back to your previous examples and see if there are other definitions you can add. Did you make definitions for the radius of circles you made? The length of your orange triangle? Try changing the code to include all of those.


##If you make a definition for the colour of your orange triangle, what did you name it? If you want to change the colour of the triangle, will you have to change the name of the definition (i.e., if you used orange, but wanted to make the triangle purple, you should probably change it to purple = "purple")? If so, that's an indication that perhaps the definition was not helpful, or didn't have a good name. Having to change the definition name means you will also have to change the uses of the definition!



##Now make a new image that puts two copies of your small yellow circle side-by-side on top of your black rectangle.
   
  
above(
  beside(
    circle-s, circle-s), 
  rectangle-big)


##Now think of a simple flag or logo design. Sketch out a plan on paper and come up with names for different parts of the design. If you have time, make definitions for each part, and compose them together to make the final image.

#FLAG RECTANGLE
width-f = 160
height-f = 100
color-f = "blue"

flag-rec = rectangle(width-f, height-f, fill, color-f)

##FLAG DESIGN
number = 60
star-f = "red"

flag-star = star(number, fill, star-f)

##FLAG

overlay(flag-star, flag-rec)
    