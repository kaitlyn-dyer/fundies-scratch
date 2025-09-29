use context starter2024
## The choose-hat Function
fun choose-hat(temp-in-C :: Number) -> String:
  doc: "determines appropriate head gear, with above 27C a sun hat, below nothing"
  ask:
    | temp-in-C >= 27 then: "sun hat"
    | temp-in-C < 10 then: "winter hat"
    | otherwise: "no hat"
  end
where: 
  choose-hat(25) is "no hat"
  choose-hat(32) is "sun hat"
  choose-hat(27) is "sun hat"
  choose-hat(9) is "winter hat"
end


### The add-glasses function
fun add-glasses(outfit :: String) -> String:
  doc: "takes an outfit and always adds glasses"
  outfit + ", and glasses"
end


##The choose-outfit function
fun choose-outfit(temp-in-C :: Number) -> String:
  doc: "takes the temp in celsius, and uses the add-glasses and choose-hat"
  outfit = choose-hat
  outfit + add-glasses
end


## the choose-hat-or-visor
fun choose-hat-or-visor(
    temp-in-C :: Number, 
    visor :: Boolean) -> String:
  doc: "indicates whether the person owns a visor and if they do and the temp is above 30C they will wear it"
  ask:
    | (temp-in-C >= 30) and visor then: "visor"
    | (temp-in-C >= 30) and not(visor) then: "sun hat"
    | temp-in-C < 10 then: "winter hat"
  end
where:
  choose-hat-or-visor(30, true) is "visor"
  choose-hat-or-visor(31, false) is "sun hat"
  choose-hat-or-visor(9, false) is "winter hat"
end
    

  


