use context dcic2024
include csv
include data-source

penguins = load-table:
  id :: Number,
  species :: String,
  island :: String,
  bill_length_mm :: Number,
  bill_depth_mm :: Number,
  flipper_length_mm :: Number,
  body_mass_g :: Number,
  sex :: String,
  year :: Number
  source: csv-table-file("penguins.csv", default-options)
  sanitize id using num-sanitizer
  sanitize bill_length_mm using num-sanitizer
  sanitize bill_depth_mm using num-sanitizer
  sanitize flipper_length_mm using num-sanitizer
  sanitize body_mass_g using num-sanitizer
  sanitize year using num-sanitizer
end

penguins


## Smaller datasets of to test the functions:
small-flippers = [list:
  penguins.row-n(0)["flipper_length_mm"],
  penguins.row-n(1)["flipper_length_mm"],
  penguins.row-n(2)["flipper_length_mm"],
  penguins.row-n(3)["flipper_length_mm"],
  penguins.row-n(4)["flipper_length_mm"]]

small-mass = [list:
  penguins.row-n(0)["body_mass_g"],
  penguins.row-n(1)["body_mass_g"],
  penguins.row-n(2)["body_mass_g"],
  penguins.row-n(3)["body_mass_g"],
  penguins.row-n(4)["body_mass_g"]]



# 1. SCALAR PROCESSING QUESTION
# Design a function that consumes a list of flipper lengths and produces the longest flipper length
fun longest_flipper(l :: List<Number>) -> Number:
  doc: "returns the longest flipper length"
  cases (List) l:
    | empty => 0
    | link(f, r) => 
      cases (List) r:
        | empty => f
        | else => num-max(f, longest_flipper(r))
      end
  end
where:
  longest_flipper(penguins.get-column("flipper_length_mm")) is 231
  longest_flipper(small-flippers) is 195
end

# 2. TRANSFORMATION QUESTION
# Design a function that consumes a list of penguin body masses in grams and produces a list of body masses converted to kilograms
fun body_mass_kg(l :: List<Number>) -> List<Number>:
  doc: "converts a list in grams to kilograms"
  cases (List) l:
    | empty => empty
    | link(f, r) => link(f / 1000, body_mass_kg(r))
  end
where:
  body_mass_kg(small-mass) is [list: 3.75, 3.8, 3.25, 3.45, 3.65]
end

# 3. SELECTION QUESTION
# Design a function that consumes a list of bill lengths and produces a list containing only bill lengths greater than 55 mm.
fun long_bills(l :: List<Number>) -> List<Number>:
  doc: "takes a list of bill lengths and produces a list containiing only bill lengths greater than 55 mm"
  cases (List) l:
    | empty => empty
    | link(f, r) => 
      if f > 55:
        link(f, long_bills(r))
      else:
        long_bills(r)
      end
  end
where: 
  long_bills(penguins.get-column("bill_length_mm")) is [list: 59.6, 55.9, 55.1, 58, 55.8]
end


# 4. ACCUMULATION QUESTION
# Design a function that consumes a list of penguin flipper lengths and produces the average
fun avg_flipper(l :: List<Number>) -> Number:
  doc: "takes a list of flipper lengths and returns the average"
  if l.length() == 0:
    0
  else:
    my-sum(l) / my-len(l)
  end
where:
  avg_flipper(penguins.get-column("flipper_length_mm")) is mean(penguins, "flipper_length_mm")
  avg_flipper(small-flippers) is 189
end

fun my-sum(l :: List<Number>) -> Number:
  sum-acc(0, l)
end


fun sum-acc(total, l):
  cases (List) l:
    | empty => total
    | link(f, r) => sum-acc(total + f, r)
  end
end

fun my-len(l :: List<Number>) -> Number:
  cases (List) l:
    | empty => 0
    | link(f, r) => 1 + my-len(r)
  end
end
    
 
  
      
      