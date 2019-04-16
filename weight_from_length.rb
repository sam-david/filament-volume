input_length = ARGV.first
input_diameter = ARGV[1] || 1.75
filament_type = ARGV[2] || "PLA"
p "INPUT LENGTH: #{input_length}m, DIAMETER: #{input_diameter}, FILAMENT TYPE: #{filament_type}"


def filament_volume(length, diameter, filament_type)
  volume_conversions_by_type = {
    "PLA" => 1.24,
    "ABS" => 1.04,
    "ASA" => 1.07,
    "PETG" => 1.27,
    "Nylon" => 1.08,
    "Polycarbonate" => 1.20,
    "HIPS" => 1.07,
    "PVA" => 1.19,
    "TPU/TPE" => 1.20,
    "PMMA" => 1.18,
    "CopperFill" => 3.90
  }

  filament_length = (length.to_f * 1000.0) # m to mm
  radius = diameter / 2
  volume = (Math::PI * radius ** 2 * filament_length) / 1000.0 # cubic mm to grams
  volume * volume_conversions_by_type[filament_type]
end

p filament_volume(input_length, input_diameter, filament_type)
