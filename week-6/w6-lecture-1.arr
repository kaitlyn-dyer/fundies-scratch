use context dcic2024
data BookRecord:
  book(title :: String, author :: String, pages :: Number)
end

the-dispossessed = book("The Dispossessed", "Ursula K. Le Guin", 387)
the-dispossessed

to-the-lighthouse = book("To the Lighthouse", "Virginia Woolf", 209)
to-the-lighthouse

brave-new-world = book("Brave New World", "Aldous Huxley", 268)
brave-new-world

## Extracting Fields:
the-dispossessed.pages

# Functions for Structured Data
fun hours-to-read(b :: BookRecord) -> Number:
  pages-per-hour = 0.83 * 60
  b.pages / pages-per-hour
end

hours-to-read(the-dispossessed)

##Conditional Data
data Priority:
  | low
  | medium
  | high
end

task-1-priority = low
task-2-priority = high
task-3-priority = medium

check:
  is-Priority(task-1-priority) is true
  is-low(task-1-priority) is true
  is-medium(task-3-priority) is true
  is-high(task-2-priority) is true
end

##Conditional Data with Fields
data Task:
  | task(description :: String, priority :: Priority)
  | note(description :: String)
end


## Defining Conditional Data
task-1 = task("Buy groceries", low)
task-2 = task("Pay council tax", high)
note-1 = note("Post Office closes at 4:30")

## Accessing Conditional Data:
fun describe(t :: Task) -> String:
  cases (Task) t:
    | task(d, p) => "TASK: " + d
    | note(d) => d
  end
end

describe(task-1) # "TASK: Buy groceries"

describe(note-1) # "Post Office closes at 4:30"


# CLASS EXERCISES
# Task Planner

# Temperature
data Temperature:
  | celcius(degrees :: Number)
  | fahrenheit(degrees :: Number)
  | kelvin(degrees :: Number)
end

ct = celcius(20)
ft = fahrenheit(80)
kt = kelvin(300)

fun to-celcius(temp :: Temperature) -> Number:
  doc: "function wich given a temperature returns a number in celsius"
  cases (Temperature) temp:
    | celcius(t) => t
    | fahrenheit(t) => (5 / 9) * (t - 32)
    | kelvin(t) => t - 273.15
  end
end

to-celcius(ct)
to-celcius(ft)
to-celcius(kt)

# Weather Report
data WeatherReport:
  | sunny(temperature :: Number)
  | rainy(temperature :: Number, precipitation :: Number)
  | snowy(temperature :: Number, precipitation :: Number, wind-speed :: Number)
end

# Make so weather reports
temp1 = sunny(30)
temp2 = sunny(36)
temp3 = rainy(23, 21)
temp4 = snowy(12, 12, 35)


# Function to determine if it is severe
fun is-severe(weather :: WeatherReport) ->  Boolean:
  doc: "function to determine if the weather is severe"
  cases(WeatherReport) weather:
    | sunny(t) => t > 35
    | rainy(t, p) => p > 20
    | snowy(t, p, w) => w > 30
  end
end

is-severe(temp1) # false
is-severe(temp2) # true
is-severe(temp3) # true
is-severe(temp4) # true
