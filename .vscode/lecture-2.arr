use context starter2024
##Look through the Pyret documentation on StringsLinks to an external site. and find how to turn a string to all uppercase, and apply it to the string "hello cs2000!".
string-to-upper("hello cs2000!")

#Create a blue circle and a yellow rectangle, then overlay them so the circle appears on top.
overlay(circle(20, "solid", "blue"), rectangle(60, 50, "solid", "yellow"))

##Stack a green rectangle above a purple rectangle using above.
above(rectangle(30, 20, "solid", "green"), rectangle(30, 20, "solid", "purple"))


##Look through the Pyret documentation on ImagesLinks to an external site., and find how to rotate an image; use that to produce a red rectangle that is 100 wide by 20 tall in two different ways.
rotate(45, rectangle(100, 20, "solid", "red"))
rotate(-45, rectangle(100, 20, "solid", "red"))


##Create a Stop sign. text, regular-polygon, and other functions you've already seen may be helpful

overlay(text("STOP", 20, "white"), overlay(regular-polygon(35, 8, "solid", "red"), overlay(regular-polygon(40, 8, "solid", "white"), regular-polygon(41, 8, "outline", "black"))))