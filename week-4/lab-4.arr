use context dcic2024
include csv
include data-source


flights = load-table:
  rownames :: Number,
  dep_time :: Number,
  sched_dep_time :: Number,
  dep_delay :: Number,
  arr_time :: Number,
  sched_arr_time :: Number,
  arr_delay :: Number,
  carrier :: String,
  flight :: Number,
  tailnum :: String,
  origin :: String,
  dest :: String, 
  air_time :: Number,
  distance :: Number,
  hour :: Number,
  minute :: Number,
  time_hour :: String
  source: csv-table-file("flights.csv", default-options)
  sanitize rownames using num-sanitizer
  sanitize dep_time using num-sanitizer  
  sanitize sched_dep_time using num-sanitizer
  sanitize dep_delay using num-sanitizer
  sanitize arr_time using num-sanitizer
  sanitize sched_arr_time using num-sanitizer
  sanitize arr_delay using num-sanitizer
  sanitize flight using num-sanitizer
  sanitize air_time using num-sanitizer
  sanitize distance using num-sanitizer
  sanitize hour using num-sanitizer
  sanitize minute using num-sanitizer
end

fun is_long_flight(row :: Row) -> Boolean:
  doc: "determines if the flight is long"
  row["distance"] >= 1500
end

flights

#PROBLEM 1

## Long flights 
long_flights = filter-with(flights, is_long_flight)

long_flights

## Longest flights
longest_flight = order-by(long_flights, "air_time", false)

# Longest flight
longest_flight.row-n(0)


#### PROBLEM 2
# We want to find flights that were delayed by at least 30 minutes, scheduled to depart in the morning, and then identify the worst offender.

fun is_delayed_departure(row :: Row) -> Boolean:
  doc: "checks if the depature is delayed by at least 30 min"
  row["dep_delay"] >= 30
end



fun is_morning_sched_dep(row :: Row) -> Boolean:
  doc: "checks if the scheduled depature time is before noon"
  row["sched_dep_time"] < 1200
end


## Find delayed flights before noon
delayed_flights = filter-with(flights, is_delayed_departure)


morning_delayed = filter-with(delayed_flights, is_morning_sched_dep)

# lambda delayed morning flights

delay = filter-with(flights, lam(r :: Row): r["dep_delay"] >= 30 end)

morning_delay = filter-with(delay, lam(d :: Row): d["sched_dep_time"] < 1200 end)

morning_delay

# filter again to keep only flights where distance > 500.

long_morning_delay = filter-with(morning_delay, lam(l :: Row): l["distance"] > 500 end)

long_morning_delay

## Order by dep_delay descending (worst delays first).

worst_delay = order-by(flights, "dep_delay", false)
worst_delay

worst_delay.row-n(0)

## PROBLEM 3

## Some flights have negative delays (meaning they left early). Replace those with 0.
no_dep_delay = transform-column(flights, "dep_delay", lam(r): if r < 0: 0 else: r end end)

no_delay = transform-column(no_dep_delay, "arr_delay", lam(s): if s < 0: 0 else: s end end)

no_delay


## Add a new column "effective_speed" in miles per hour:

effective_flights = build-column(flights, "effective_speed", lam(r :: Row): if r["air_time"] < 0: 0 else: r["distance"] / (r["air_time"] / 60) end end)


flights = load-table:
  rownames :: Number,
  dep_time :: Number,
  sched_dep_time :: Number,
  dep_delay :: Number,
  arr_time :: Number,
  sched_arr_time :: Number,
  arr_delay :: Number,
  carrier :: String,
  flight :: Number,
  tailnum :: String,
  origin :: String,
  dest :: String,
  air_time :: Number,
  distance :: Number,
  hour :: Number,
  minute :: Number,
  time_hour :: String
  source: csv-table-file("flights.csv", default-options)
  sanitize rownames using num-sanitizer
  sanitize dep_time using num-sanitizer
  sanitize sched_dep_time using num-sanitizer
  sanitize dep_delay using num-sanitizer
  sanitize arr_time using num-sanitizer
  sanitize sched_arr_time using num-sanitizer
  sanitize arr_delay using num-sanitizer
  sanitize flight using num-sanitizer
  sanitize air_time using num-sanitizer
  sanitize distance using num-sanitizer
  sanitize hour using num-sanitizer
  sanitize minute using num-sanitizer
end

flights

## EXERCISE 1: Long Flights
# Define long flights
fun is_long_flight(row :: Row) -> Boolean:
  doc: "defines long flights"
  row["distance"] >= 1500
end


## Create a new table with long flights only
long-flights = filter-with(flights, is_long_flight)

long-flights


# Order starting with the longest flight
longest-flight = order-by(long-flights, "air_time", false)

longest-flight

#Extract the carrier, origin, and dest of the first row
longest-flight.row-n(0)


### EXERCISE 2: Delayed Morning Flights
# Define the delayed flights
fun is_delayed_departure(row :: Row) -> Boolean:
  row["dep_delay"] >= 30
end

# Checks if the scheduled departure time is before noon
fun is_morning_sched_dep(row :: Row) -> Boolean:
  row["sched_dep_time"] < 1200
end

# Use a lambda with filter-with to keep flights with delayed departures (≥ 30). Chain another lambda filter to keep only flights scheduled before noon.

all-delayed-flights = filter-with(flights, lam(r :: Row): r["dep_delay"] >= 30 end)

morn-delayed-flights = filter-with(all-delayed-flights, lam(r :: Row): r["sched_dep_time"] < 1200 end)

morn-delayed-flights

# Filter again to keep only flights where distance > 500

long-morn-delayed = filter-with(morn-delayed-flights, lam(r :: Row): r["distance"] > 500 end)

longest-morn-delay = order-by(long-morn-delayed, "dep_delay", false)

longest-morn-delay.row-n(0)

## EXERCISE 3: Clean Delays + compute Effective Speed
# Clean negative depature and arrival delays
cleaning = transform-column(flights, "dep_delay", lam(val): if val < 0: 0 else: val end end)

clean_delays = transform-column(cleaning, "arr_delay", lam(v): if v < 0: 0 else: v end end)
clean_delays

# Create effective speed column mph

flights-speed = build-column(clean_delays, "effective_speed", lam(s): if s["air_time"] > 0: s["distance"] / (s["air_time"] / 60) else: 0 end end)

desc-flights-speed = order-by(flights-speed, "effective_speed", false)
desc-flights-speed

desc-flights-speed.row-n(0)


## EXERCISE 4: Discount Late Arrivals and On-Time Score
fun apply-arrival-discount(t :: Table) -> Table:
  doc: "Reduces arr_delay by 20% when 0 <= arr_delay <= 45"
  transform-column(t, "arr_delay", lam(val): if (val >= 0) and (val <= 45): val * 0.8 else: val end end)
end

discounted-flights = apply-arrival-discount(flights)

discounted-flights

# Add new column with scoing idea

scored-flights = build-column(
  clean_delays, 
  "on_time_score", 
  lam(row): 
  score = 100 - (row["dep_delay"] - row["arr_delay"]) - (row["air_time"] / 30) 
  if score < 0: 
      0 
  else: 
      score
    end
  end)

best-flights = order-by(scored-flights, "on_time_score", false)

best-flights-tied = order-by(best-flights, "distance", true)

best-flights-tied

best-flights-tied.row-n(0)
best-flights-tied.row-n(1)

