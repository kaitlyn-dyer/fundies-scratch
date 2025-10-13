use context dcic2024
include csv
include data-source
import math as M
import statistics as S
import lists as L

flights_sample53 = load-table:
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
  source: csv-table-file("flights_sample53.csv", default-options)
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

## TASK 2: Handle Missing Data, Clean Data, and Identify Duplicates
# Replace missing values with "UNKNOWN"
replace-missing = transform-column(flights_sample53, "tailnum", lam(r): if r == "": "UNKNOWN" else: r end end)

replace-missing

# Replace negative values with 0
negative-del = transform-column(flights_sample53, "dep_delay", lam(r): if r < 0: 0 else: r end end)

no-delay =  transform-column(negative-del, "arr_delay", lam(r): if r < 0: 0 else: r end end)

no-delay

# Identify Duplicate Rows from the Table
string-flights = transform-column(flights_sample53, "flight", num-to-string)
  
fun trim(s :: String) -> String:
  doc: "removes spaces from given string"
  n = string-length(s)
  if n == 0:
    ""
  else: 
    string-replace(s, " ", "")
  end
end

fun clock-format(time-num :: Number) -> String:
  doc: "converts time number to HH:MM format"
  # convert to string
  time-string = num-to-string(time-num)
  # get length of string
  time-length = string-length(time-string)
  # MINUTE substring
  minutes = string-substring(time-string, time-length - 2, time-length)
  # HOUR substring
  hours = string-substring(time-string, 0, time-length - 2)
  # FIXING HOURS
  format-hours = 
    if string-length(hours) == 1:
      "0" + hours
    else if string-length(hours) == 0:
      "00" + hours
    else: 
      hours
    end
  clock = format-hours + ":" + minutes
  clock
end

dedup_table = build-column(string-flights, "dedup_key", lam(r): r["flight"] + "-" + trim(r["carrier"]) + "-" + clock-format(r["dep_time"]) end)

# FINDING DUPLICATE
group(dedup_table, "dedup_key")



## DO TASK 3


# TASK 4: Visualisation & for each Loop
freq-bar-chart(flights_sample53, "carrier")
histogram(flights_sample53, "distance", 500)
scatter-plot(flights_sample53, "air_time", "distance")

# Extract the "distance" column as a list
list-dis = flights_sample53.get-column("distance")

# Total distance flown
fun total-dis(num-list :: List<Number>) -> Number block:
  var total = 0
  for each(n from num-list):
    total := total + n
  end
  total
end

total-dis(list-dis)

# Average distance







