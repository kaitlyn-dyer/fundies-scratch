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



# 1. SCALAR PROCESSING QUESTION
# What are the flipper lengths of all Adelie penguins observed on Torgersen Island? Extract the longest flipper length.
adelie-torgersen = filter-with(penguins, lam(r): (r["species"] == "Adelie") and (r["island"] == "Torgersen") end)

longest-flipper = order-by(adelie-torgersen, "flipper_length_mm", false)
longest-flipper

longest-flipper.row-n(0)

# 2. TRANSFORMATION QUESTION
# Change every penguin's body mass from grams to kilograms and create a new column named body_mass_kg
penguins-kg = build-column(penguins, "body_mass_kg", lam(r): (r["body_mass_g"] / 1000) end)
penguins-kg

# 3. SELECTION QUESTION
# Which Gentoo penguins have a bill length greater than 55 mm?
long-gentoo = filter-with(penguins, lam(r): (r["species"] == "Gentoo") and (r["bill_length_mm"] > 55) end)
long-gentoo

# 4. ACCUMULATION QUESTION
# What is the average flipper length of female vs. male Chinstrap penguins?
fem-chinstrap = filter-with(penguins, lam(r): (r["species"] == "Chinstrap") and (r["sex"] == "female") end)
mean(fem-chinstrap, "flipper_length_mm")

box-plot(fem-chinstrap, "flipper_length_mm")

male-chinstrap = filter-with(penguins, lam(r): (r["species"] == "Chinstrap") and (r["sex"] == "male") end)
mean(male-chinstrap, "flipper_length_mm")

box-plot(male-chinstrap, "flipper_length_mm")
 