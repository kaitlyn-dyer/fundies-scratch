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

  