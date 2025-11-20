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
bill-length = penguins.get-column("bill_length_mm")

flipper-length = penguins.get-column("flipper_length_mm")

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


adelie = filter-with(penguins, lam(r): r["species"] == "Adelie" end)

chinstrap = filter-with(penguins, lam(r): r["species"] == "Chinstrap" end)

gentoo = filter-with(penguins, lam(r): r["species"] == "Gentoo" end)

adelie-flip = adelie.get-column("flipper_length_mm")

chinstrap-flip = chinstrap.get-column("flipper_length_mm")

gentoo-flip = gentoo.get-column("flipper_length_mm")


adelie-flip-small = [list:
  adelie.row-n(10)["body_mass_g"],
  adelie.row-n(11)["body_mass_g"],
  adelie.row-n(12)["body_mass_g"]]
adelie-flip-small

# 1. SCALAR PROCESSING QUESTION
# What is the longest flipper length?
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
  longest_flipper(flipper-length) is 231
  longest_flipper(adelie-flip) is 210
  longest_flipper(chinstrap-flip) is 212
  longest_flipper(gentoo-flip) is 231
end

# 2. TRANSFORMATION QUESTION
# What are the penguins body masses in kilograms?
fun body_mass_kg(l :: List<Number>) -> List<Number>:
  doc: "converts a list in grams to kilograms"
  cases (List) l:
    | empty => empty
    | link(f, r) => link(f / 1000, body_mass_kg(r))
  end
where:
  body_mass_kg(small-mass) is [list: 3.75, 3.8, 3.25, 3.45, 3.65]
  body_mass_kg(adelie-flip-small) is [list: 3.7, 3.45, 4.5]
  body_mass_kg([list: 3750, 3800, 3250, 3450, 3650]) is link(3750 / 1000, body_mass_kg([list: 3800, 3250, 3450, 3650]))
  body_mass_kg([list: 3800, 3250, 3450, 3650]) is link(3800 / 1000, body_mass_kg([list: 3250, 3450, 3650]))
  body_mass_kg([list: 3250, 3450, 3650]) is link(3250 / 1000, body_mass_kg([list: 3450, 3650]))
  body_mass_kg([list: 3450, 3650]) is link(3450 / 1000, body_mass_kg([list: 3650]))
  body_mass_kg([list: 3650]) is link(3650 / 1000, body_mass_kg([list: ]))
  body_mass_kg([list: ]) is empty
end

# 3. SELECTION QUESTION
# What are the bill lengths that are greater than a given number? 
fun long_bills(l :: List<Number>, x :: Number) -> List<Number>:
  doc: "takes a list of bill lengths and produces a list containiing only bill lengths greater than 55 mm"
  cases (List) l:
    | empty => empty
    | link(f, r) => 
      if f > x:
        link(f, long_bills(r, x))
      else:
        long_bills(r, x)
      end
  end
where: 
  long_bills(bill-length, 55) is [list: 59.6, 55.9, 55.1, 58, 55.8]
  long_bills(bill-length, 56) is [list: 59.6, 58]
  long_bills(bill-length, 58) is [list: 59.6]
end


# 4. ACCUMULATION QUESTION
# What is the average flipper length rounded to the neared integer?
fun avg_flipper(l :: List<Number>) -> Number:
  doc: "takes a list of flipper lengths and returns the average"
  if my-len(l) == 0:
    0
  else:
    num-round(my-sum(l) / my-len(l))
  end
where:
  avg_flipper(flipper-length) is 201
  avg_flipper(small-flippers) is 189
  avg_flipper(adelie-flip) is 190
  avg_flipper(chinstrap-flip) is 196
  avg_flipper(gentoo-flip) is 217
end
## This tells us that the Gentoo penguin is the species with the longest flipper on average from this sample.

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



  
      
      