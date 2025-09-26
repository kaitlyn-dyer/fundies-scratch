use context dcic2024
include csv
include data-source

plants = load-table:
  plant_common_name :: String,
  location_latitude :: Number,
  location_longitude :: Number,
  date_sighted :: String,
  soil_type :: String,
  plant_height_cm :: Number,
  plant_color :: String
  source: csv-table-url("https://raw.githubusercontent.com/NU-London/LCSCI4207-datasets/refs/heads/main/plant_sightings.csv", default-options)
end



glucose = load-table:
  patient_id :: Number,
  glucose_level :: Number,
  date_time :: String,
  insulin_dose :: Number,
  exercise_duration :: Number,
  stress_level :: Number
  source: csv-table-file("glucose_levels.csv", default-options)
  sanitize patient_id using num-sanitizer
  sanitize glucose_level using num-sanitizer
  sanitize insulin_dose using num-sanitizer
  sanitize exercise_duration using num-sanitizer
  sanitize stress_level using num-sanitizer
end

histogram(glucose, "glucose_level", 10)

median(glucose, "insulin_dose")

scatter-plot(glucose, "glucose_level", "insulin_dose")

  
  