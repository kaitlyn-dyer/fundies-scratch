use context dcic2024
include csv
include data-source
import math as M
import statistics as S
import lists as L

# Practice with tables
cafe-data = table: day, drinks-sold
  row: "Mon", 45
  row: "Tue", 30
  row: "Wed", 55
  row: "Thu", 40
  row: "Fri", 60
end

cafe-data

cafe-data.get-column("day")

cafe-data.row-n(1)

# Practice with lists
discount-codes = [list: "NEWYEAR", "student", "NONE", "student", "VIP", "none"]

discount-codes

unique-codes = distinct(discount-codes)

unique-codes

fun is-real-code(code :: String) -> Boolean:
  not(string-to-lower(code) == "none")
end

real-codes = filter(is-real-code, unique-codes)

real-codes

# Recalling one item in a code
real-codes.get(2)

# Practice using map on lists to transform a list
map(string-to-upper, real-codes)

map(string-to-lower, real-codes)


# Practice with variables
var practice = 2
practice := practice + 12
practice


fun my-sum(num-list :: List<Number>) -> Number block:
  var total = 0
  for each(n from num-list):
    total := total + n
  end
  total
where:
  my-sum([list: 0, 1, 2, 3,]) is 6
end

# CLASS EXERCISES

#List Operations
map(string-to-upper, discount-codes)

survey-resp = [list: "yes", "NO", "maybe", "Yes", "no", "Maybe"]
survey-resp

low-distinct = distinct(map(string-to-lower, survey-resp))

definitive = filter(lam(d): not(d == "maybe") end, low-distinct)
definitive

#Loops
#Define your own product function that takes a list of numbers and returns their product (multiply all of them together).
fun product(num-list :: List<Number>) -> Number block:
  doc: "takes a list of numbers and returns their product"
  var total = 1
  for each(n from num-list):
    total := total * n
  end
  total
where:
  product([list: 1, 2, 4]) is 8
  product([list: 0, 22, 3, 7]) is 0
end

product([list: 1, 3, 22])


#Define a function sum-even-numbers that takes a list of integers and adds up only the even numbers—the rest should be ignored (num-moduloLinks to an external site. may be helpful)!
fun sum-even-numbers(num-list :: List<Number>) -> Number block:
  doc: "takes a list of integers and adds up only the even numbers"
  even = filter(lam(e): num-modulo(e, 2) == 0 end, num-list)
  var total = 0
    for each(n from even):
    total := total + n
  end
  total
where:
  sum-even-numbers([list: 1, 4, 3]) is 4
  sum-even-numbers([list: 1, 3, 7]) is 0
end

sum-even-numbers([list: 1, 4, 6, 6])

#Define a function my-length that takes a list of any value and returns the number of elements in the list.
fun my-length(l :: List) -> Number block:
  doc: "takes a list of any value and returns the number of elements"
  var total = 0
  for each(n from l):
    total := total + 1
  end
  total
where:
  my-length([list: 1, 55, 3]) is 3
  my-length([list: 3, 5, 7, 8, 1, 2]) is 6
end

my-length([list: 1, 1, 1, 1, 1, 1, 1, "hey"])

#Design a function my-doubles that takes a list of numbers and returns a new list where each element is twice what the corresponding element was in the original list.
fun my-doubles(num-list :: List<Number>) -> List block:
  doc: "takes a list of numbers and returns a new list where each element is twice what the corresponding element was"
  var double-num = [list: ]
  for each(n from num-list):
    double-num := double-num.append([list: n * 2])
  end
  double-num
where:
  my-doubles([list: 1, 2, 3]) is [list: 2, 4, 6]
end
  
#Re-implement the same function as my-doubles-map using map from the lists library. Which implementation do you find clearer?
fun my-doubles-map(x :: List) -> List block:
  map(lam(y): y * 2 end, x)
end

#Design my-string-lens which takes a list of strings and returns a new list where each element is the length of the string in the corresponding position in the input list.
fun my-string-lens(l :: List<String>) -> List<Number> block:
  doc: "takes a list of strings and returns a new list where each element is the length of the string"
  var string-len = [list: ]
  for each(s from l):
    string-len := link(string-length(s), string-len)
    end
  reverse(string-len)
where:
  my-string-lens([list: "sad", "hi", "kaitlyn"]) is [list: 3, 2, 7]
end
    
#Re-implement the same function as my-string-lens-map using map from the lists library. Which implementation do you find clearer?
fun my-string-lens-map(l :: List<String>) -> List<Number>:
  map(lam(s): string-length(s) end, l)
end

my-string-lens-map([list: "hi", "hey"])


#Design my-alternating, which takes a list of any element and returns a new list that contains every other element—i.e., keep the first, skip the second, etc. Note: you may need two mutable variables for this one—one to contain the result, as normal, but the other to keep track of the alternation.