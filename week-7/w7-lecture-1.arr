use context starter2024
fun my-pos-num(l):
  doc: "select for all positive numbers"
  cases (List) l:
    | empty => empty
    | link(f, r) => 
      ask: 
        | f > 0 then: link(f, my-pos-num(r))
        | otherwise: my-pos-num(r)
      end
  end
where: 
  my-pos-num([list: 1, -1, 2, -2]) is [list: 1, 2]
end





fun my-running-sum(l):
  doc: "add up the numbers along a list"
  my-rs(0, l)
where:
  my-running-sum([list: 1, 2, 3]) is [list: 1, 3, 6]
end


fun my-rs(acc, l):
  cases (List) l:
    | empty => empty
    | link(f, r) => link(f + acc, my-rs(f + acc, r))
  end
end



# CLASS EXERCISES
# PROBLEM 1: Selection
fun more-than-five(l :: List<String>):
  doc: "function that creates a new list that contains elements with more than five characters"
  cases (List) l:
    | empty => empty
    | link(f, r) => 
      ask:
        | string-length(f) > 5 then: link(f, more-than-five(r))
        | otherwise: more-than-five(r)
      end
  end
where: 
  more-than-five([list: "kaitlyn", "darya"]) is [list: "kaitlyn"]
end


# PROBLEM 2: Relaxed Domains
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


fun my-average(l :: List<Number>):
  doc: "determines the average from the list of numbers"
  cases (List) l: 
    | empty => 0
    | else => my-sum(l) / my-len(l)
  end
where: 
  my-average([list: 1, 2]) is 1.5
end

#PROBLEM 3: Accumulators
fun my-alternating(l):
  doc: "select all other elements"
  cases (List) l:
    | empty => empty
    | link(f, r) => 
      cases (List) r:
        | empty => empty
        | link(fr, rr) => link(f, my-alternating(rr))
      end
  end
where:
  my-alternating([list: 1, 2, 3, 4]) is [list: 1, 3]
end

fun my-alternating-acc(l):
  m-a(l, true)
where: 
  my-alternating-acc([list: 1, 2, 3, 4]) is [list: 1, 3]
end

fun m-a(l, keep):
  cases (List) l:
    | empty => empty
    | link(f, r) =>
      ask:
        | keep then: link(f, m-a(r, false))
        | otherwise: m-a(r, true)
      end
  end
end

fun my-max(l):
  doc: "find the max from a list, make sure its not empty"
  cases (List) l:
    | empty => raise("cant max an empty list")
    | link(f, r) => 
      cases (List) r:
        | empty => f
        | else => num-max(f, my-max(r))
      end
  end
where:
  my-max([list: 1, 3, 4]) is 4
  my-max([list: ]) raises "cant max an empty list"
end


fun my-max-acc(l):
  m-m(0, l)
where: 
  my-max-acc([list: 1, 2, 3]) is 3
end

fun m-m(acc, l):
  cases (List) l:
    | empty => acc
    | link(f, r) => 
      ask:
        | acc > f then: m-m(acc, r)
        | otherwise: m-m(f, r)
      end
  end
end
