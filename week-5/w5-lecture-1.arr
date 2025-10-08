use context dcic2024
include csv 
include data-source 

# voter-data table 
voter-data = load-table: 
  VoterID, 
  DOB, 
  Party, 
  Address, 
  City, 
  County, 
  Postcode 
  source: csv-table-url("http://raw.githubusercontent.com/NU-London/LCSCI4207-datasets/refs/heads/main/voters.csv", default-options) 
  sanitize VoterID using string-sanitizer 
  sanitize DOB using string-sanitizer 
  sanitize Party using string-sanitizer 
  sanitize Address using string-sanitizer 
  sanitize City using string-sanitizer 
  sanitize County using string-sanitizer 
  sanitize Postcode using string-sanitizer 
end 

voter-data 

  
##figure out how many people are in the labour party 
filter-with(voter-data, lam(r): r["Party"] == "Labour" end).length() 


### extract the party name from row 3 
voter-data.row-n(3)["Party"]  


fun fix-party(party): 
  if party == "Labour": 
    "Labour" 
  else: 
    party 
  end 
end 


voter-data-clean = transform-column(voter-data, "Party", fix-party) 

filter-with(voter-data-clean, lam(r): r["Party"] == "Labour" end).length() 


##change "" to "Undecided" 
fun blank-to-undecided(s :: String) -> String: 
  doc: "replaces an empty string with Undecided" 
  if s == "": 
    "Undecided" 
  else: 
    s 
  end 
where: 
  blank-to-undecided("") is "Undecided" 
  blank-to-undecided("blah") is "blah" 
end 
  

undecided-voters = transform-column(voter-data, "Party", blank-to-undecided) 

 

## Frequency bar chart 
freq-bar-chart(undecided-voters, "Party") 
  

##### CLASS EXERCISES 
# Design a function called normalize-date that takes the current DD/MM/YYYY format in the DOB column and turns it into ISO format YYYY-MM-DD 
fun normalize-date(date-string :: String) -> String: 
  doc: "coverts DD/MM/YYYY to YYYY-MM-DD format" 
  day = string-substring(date-string, 0, 2) 
  month = string-substring(date-string, 3, 5) 
  year = string-substring(date-string, 6, 10) 
  year + "-" + month + "-" + day 
end 
  
new-voter-data = transform-column(voter-data, "DOB", normalize-date) 


# Design a function called normalize-postcode that transforms all the postcodes to use the following format: All letters in capitals, The first part of the postcode can be up to four characters long, This should be followed by a space, The last part of the postcode is always three characters long, Think about a strategy using string-substring (multiple times, with comparisons) 
fun normalize-postcode(postcode :: String) -> String: 
  upper-postcode = string-to-upper(postcode) 
  no-spaces = string-replace(upper-postcode, " ", "") 
  total-length = string-length(no-spaces) 
  ending = string-substring(no-spaces, total-length - 3, total-length) 
  beginning = string-substring(no-spaces, 0, total-length - 3) 
  beginning + " " + ending 
end 

 
  

transform-column(voter-data, "Postcode", normalize-postcode) 

 

 