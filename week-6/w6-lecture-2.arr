use context starter2024
#|
data List <a>:
  | empty
  | link(first :: a, rest :: List<a>)
end

|#

check:
  [list: 1, 2, 3] is link(1, link(2, link(3, empty)))
end


link(1, link(2, link(3, empty))).rest.rest


fun my-len(l :: List) -> Number:
  doc: "returns the number of elements in the given list"
  cases (List) l:
    | empty => 0
    | link(f, r) => 1 + my-len(r)
  end
where:
  my-len([list: 1, 2, 3]) is 3
  my-len([list: 1, 2, 3]) is 1 + my-len([list: 2, 3])
  my-len([list: 2, 3]) is 1 + my-len([list: 3])
  my-len([list: 3]) is 1 + my-len([list: ])
  my-len([list: ]) is 0
end
my-len([list: 9, 100, 2, "4"]) #4


fun my-sum(l :: List<Number>) -> Number:
  cases (List) l:
    | empty => 0
    | link(f, r) => f + my-sum(r)
  end
where:
  my-sum([list: 1, 2, 3]) is 6
end
my-sum([list: 5, 4]) #9


fun my-double(l) -> List:
  cases (List) l:
    | empty => empty
    | link(f, r) => link(f * 2, my-double(r))
  end
where:
  my-double([list: 3, 5, 2]) is [list: 6, 10, 4]
  my-double([list: 3, 5, 2]) is link(3 * 2, my-double([list: 5, 2]))
  my-double([list: 5, 2]) is link(5 * 2, my-double([list: 2]))
  my-double([list: 2]) is link(2 * 2, my-double([list: ]))
  my-double([list: ]) is empty
end
my-double([list: 2, 3, 5])

# Class Exercises
# PROBLEM 1: Scalar Processing: String Concantante

# Design a function called string-concat that takes a list of strings and joins them all together into a single string.
fun string-concat(l :: List<String>) -> String:
  doc: "function that takes a list of strings and joins them together"
  cases (List) l:
    | empty => ""
    | link(f, r) =>  f + string-concat(r)
  end
where: 
  string-concat([list: "1", "2", "3"]) is "123"
  string-concat([list: "2", "3"]) is "23"
  string-concat([list: "3"]) is "3" 
  string-concat([list: ]) is ""
end
  
  



# PROBLEM 2: List Transformation: Strings Upper

# Design a function called strings-upper which, given a list of strings returns a list of strings with all the values upper-case
fun strings-upper(l :: List<String>) -> List<String>:
  doc: "returns given list of strings with all uppercase"
  cases (List) l:
    | empty => empty
    | link(f, r) => link(string-to-upper(f), strings-upper(r))
  end
where:
  strings-upper([list: "hello", "hi"]) is [list: "HELLO", "HI"]
  strings-upper([list: "a", "b", "c"]) is [list: "A", "B", "C"]
end




# PROBLEM 3: List Transformation: Rounding

#Design a function called round-numbers which, given a list of decimal (floating-point) numbers, returns a list with each number rounded to the closest integer.

fun round-numbers(l :: List<Number>) -> List<Number>:
  doc: "function that given a list of decimal numbers returns rounded number"
  cases (List) l:
    | empty => empty
    | link(f, r) => link(num-round(f), round-numbers(r))
  end
where:
  round-numbers([list: 2.2, 1.7]) is [list: 2, 2]
  round-numbers([list: 4.4, -9.1]) is [list: 4, -9]
end
  
  