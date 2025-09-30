use context dcic2024
include csv
include data-source

orders = table: time, amount
  row: "08:00", 10.50
  row: "09:30", 5.75
  row: "10:15", 8.00
  row: "11:00", 3.95
  row: "14:00", 4.95
  row: "16:45", 7.95
end


## Function to check if a row is the morning
fun is-morning(r :: Row) -> Boolean:
  r["time"] < "12:00"
end
  

# Filter the table 
morning-orders = filter-with(orders, is-morning)
morning-orders


order-by(orders, "time", true)

# Write code to extract the amount of the latest morning order
order-by(orders, "time", true).row-n(3)






# LOADING DATA

table-1 = load-table:
  location :: String, 
  subject :: String, 
  date :: String
  source: csv-table-url("https://raw.githubusercontent.com/NU-London/LCSCI4207-datasets/refs/heads/main/photos.csv", default-options)
end

#Now filter rows that have the subject "Forest" to create a new table.
table-2 = filter-with(table-1, lam(f): f["subject"] == "Forest" end)


# Order the resulting new table by date, and extract the location from the most recent row.
order-by(table-2, "date", false)
order-by(table-2, "date", false).row-n(0)

#Count how many photos were taken in each Location using the count table function
amount = count(table-1, "location")

## Order the returned table so that we can see the locations where the most photos were taken

order-by(amount, "count", true)

##Create a frequency-bar-chart using the original table for the Location column

freq-bar-chart(table-1, "location")
