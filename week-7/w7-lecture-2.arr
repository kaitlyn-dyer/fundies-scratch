use context starter2024
data River:
  | merge(width :: Number, left :: River, right :: River)
  | stream(flow-rate :: Number)
end

# Example: A small river network
stream-a = stream(5)
stream-b = stream(3)
stream-c = stream(8)

merge-1 = merge(12, stream-a, stream-b)
main-river = merge(15, merge-1, stream-c)


fun total-flow(r :: River) -> Number:
  cases (River) r:
    | merge(width, left, right) => total-flow(left) + total-flow(right)
    | stream(flow) => flow
  end
where:
  total-flow(stream-a) is 5
  total-flow(main-river) is 16
end


fun count-merges(r :: River) -> Number:
  cases (River) r:
    | merge(width, left, right) => 1 + count-merges(left) + count-merges(right)
    | stream(flow) => 0
  end
where:
  count-merges(stream-a) is 0
  count-merges(main-river) is 2
end

# CLASS EXERCISES
# PROBLEM 1: Design a function count-streams which counts how many individual streams feed into a river network
fun count-streams(r :: River) -> Number:
  doc: "counts how many individual streams feed into a river network"
  cases (River) r:
    | stream(flow) => 1
    | merge(width, left, right) => count-streams(left) + count-streams(right)
  end
where: 
  count-streams(stream-a) is 1
  count-streams(main-river) is 3
end


# PROBLEM 2: Design a function max-width that finds the maximum width among all merge points in a river network
fun max-width(r :: River) -> Number:
  doc: "finds the max width amoung all merge points"
  cases (River) r:
    | merge(width, left, right) => num-max(width, num-max(max-width(left), max-width(right)))
    | stream(flow) => 0
  end
where: 
  max-width(merge-1) is 12
  max-width(main-river) is 15
end
      


# PROBLEM 3: Design a function widen-river that takes a river network and a number, and returns a new network where every merge point is wider by that amount
fun widen-river(r :: River, amount :: Number) -> River:
  doc: "returns a new river network where every merge point is wider by the given amount"
  cases (River) r:
    | merge(width, left, right) => merge(width + amount, widen-river(left, amount), widen-river(right, amount))
    | stream(flow) => stream(flow)
  end
where:
  widen-river(main-river, 5) is merge(20, merge(17, stream(5), stream(3)), stream(8))
end



# PROBLEM 4: Design a function cap-flow that takes a river network and returns a new network where no stream has flow-rate above a given number (cap any higher values at the given number)
fun cap-flow(r :: River, max-flow:: Number) -> River:
  doc: "returns a new network where no stream has flow-rate above a given number"
  cases (River) r:
    | stream(flow) => stream(num-min(flow, max-flow))
    | merge(width, left, right) => merge(width, cap-flow(left, max-flow), cap-flow(right, max-flow))
  end
where: 
  cap-flow(main-river, 6) is merge(15, merge(12, stream(5), stream(3)), stream(6))
end

   

# PROBLEM 5: Design a function has-large-stream that returns true if any stream in the network has flow-rate greater than 5