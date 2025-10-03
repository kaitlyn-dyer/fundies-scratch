use context dcic2024
include csv
include data-source

# Items Table
items = table: item :: String, x-coordinate :: Number, y-coordinate :: Number
  row: "Sword of Dawn",           23,  -87
  row: "Healing Potion",         -45,   12
  row: "Dragon Shield",           78,  -56
  row: "Magic Staff",             -9,   64
  row: "Elixir of Strength",      51,  -33
  row: "Cloak of Invisibility",  -66,    5
  row: "Ring of Fire",            38,  -92
  row: "Boots of Swiftness",     -17,   49
  row: "Amulet of Protection",    82,  -74
  row: "Orb of Wisdom",          -29,  -21
end

items
## Takes a function that transforms a single column, we could use the following function
fun subtract-1(n :: Number) -> Number:
  doc: "subtracts 1 from input"
  n - 1
where:
  subtract-1(10) is 9
  subtract-1(0) is -1
  subtract-1(-3.5) is -4.5
end

## Shifted table
moved-items = transform-column(items, "x-coordinate", subtract-1)


## New column
fun calc-distance(r :: Row) -> Number:
  doc: "does distance to origin from fields 'x-coordinate' and 'y-coordinate'"
  rough-num = num-sqrt(
    num-sqr(r["x-coordinate"]) + num-sqr(r["y-coordinate"]))
  num-exact(rough-num)
where:
  calc-distance(items.row-n(0)) is-roughly
    num-sqrt(num-sqr(23) + num-sqr(-87))
      
  calc-distance(items.row-n(3)) is-roughly
    num-sqrt(num-sqr(-9) + num-sqr(64))
end


## New table
items-with-dist = build-column(items, "distance", calc-distance)

items-with-dist

## Problem 1: Items Table
new_tablex = transform-column(items, "x-coordinate", lam(n): n * 0.1 end)
new_tablexy = transform-column(new_tablex, "y-coordinate", lam(f): f * 0.1 end)



closer-items = build-column(new_tablexy, "distance", calc-distance)

closer-items

##Extract the name of the item that is closest to the player.

closest-item = order-by(closer-items, "distance", true)

closest-item

closest-item.row-n(0)

##You want to "obfuscate" the list of items, displaying, rather than the name, a string that is a sequence of "X"s of the same length.

fun characters-x(name :: String) -> String:
  doc: "characters to X"
  string-repeat("X", string-length(name))
end

obfuscated = transform-column(items, "item", characters-x)

obfuscated