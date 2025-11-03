use context starter2024
data SensorNet:
  | hub(bandwidth :: Number, left :: SensorNet, right :: SensorNet)
  | sensor(rate :: Number)
end

# Example network:
sA = sensor(60)
sB = sensor(120)
sC = sensor(45)
hub1 = hub(150, sA, sB)
core = hub(200, hub1, sC)
core2 = hub(225, hub1, sC)

# TASK 1 - Compute Total Offered Load:
fun total-load(n :: SensorNet) -> Number:
  doc: "returns the sum of all sensor rates"
  cases (SensorNet) n:
    | sensor(rate) => rate
    | hub(bandwidth, left, right) => total-load(left) + total-load(right)
  end
where:
  total-load(hub1) is 180
  total-load(core) is 225
end

# TASK 2 - Check Capacity Feasibility:
fun fits-capacities(n :: SensorNet) -> Boolean:
  doc: "takes a SensorNet and returns boolean, true if every hub's bandwidth is at least as large as the total load of its left and right sub-networks, and false otherwise"
  cases (SensorNet) n:
    | sensor(rate) => rate
    | hub(bandwidth, left, right) => 
      ask: 
        | bandwidth >= total-load(n) then: true
        | otherwise: false
      end
  end
where:
  fits-capacities(hub1) is false
  fits-capacities(core) is false
  fits-capacities(core2) is true
end

# TASK 3 - Depth of the Deepest Sensor:
fun deepest-depth(n :: SensorNet) -> Number:
  doc: "returns the depth of the deepest sensor"
  cases (SensorNet) n:
    | sensor(rate) => 0
    | hub(bandwidth, left, right) => 1 + num-max(deepest-depth(left), deepest-depth(right))
  end
where:
  deepest-depth(sA) is 0
  deepest-depth(hub1) is 1
  deepest-depth(core) is 2
end

# TASK 4 - Apply a Scaling Factor:
fun needed-scale(n :: SensorNet) -> Number:
  cases (SensorNet) n:
    | sensor(rate)  => 1
    | hub(bw, l, r) =>
      block:
        load = total-load(l) + total-load(r)
        here = load / bw
        num-max( num-max(here, needed-scale(l)), needed-scale(r) )
      end
  end
where:
  needed-scale(core) is 1.2
end

fun apply-scale(n :: SensorNet, s :: Number) -> SensorNet:
  doc: "using recursion that applies a given scaling facotr s to all sensor rates, returning a new, scaled network"
  cases (SensorNet) n:
    | sensor(rate) => sensor(rate / s)
    | hub(bandwidth, left, right) => hub(bandwidth, apply-scale(left, s), apply-scale(right, s))
  end
where:
  apply-scale(sA, 2) is sensor(30)
  apply-scale(hub1, 1.5) is hub(150, sensor(40), sensor(80))
  total-load(apply-scale(core, 1.2)) is 187.5
  fits-capacities(apply-scale(core, needed-scale(core))) is true
end
  

# TASK 5 - Scale the Network to Fit:
fun scale-to-fit(n :: SensorNet) -> SensorNet:
  doc: "makes the network feasible by scaling it just enough"
  s = needed-scale(n)
  if s <= 1:
    n
  else:
    apply-scale(n, s)
  end
where: 
  fits-capacities(scale-to-fit(core)) is true
  total-load(scale-to-fit(core)) is 225 / 1.2
  fits-capacities(scale-to-fit(core2)) is true
end