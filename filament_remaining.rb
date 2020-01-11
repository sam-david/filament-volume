require 'google_drive'
require 'pry'

SESSION = GoogleDrive::Session.from_config("google_cred.json")
SPREADSHEET = SESSION.collection_by_title('3D').subfolder_by_name('Filament').file_by_name('Spool Weights').worksheets[0]

def spool_options
  spreadsheet_no_headers = SPREADSHEET.rows.dup
  spreadsheet_no_headers.shift
  spreadsheet_no_headers.map do |row|
    {
      brand: row[0],
      capacity: row[1].to_i,
      spool_weight: row[2].to_i
    }
  end
end

def select_spool_option
  puts "Please select which spool Brand and Capacity:"
  spool_options.each_with_index do |so, i|
    puts "#{i + 1}: #{so[:brand]} - #{so[:capacity]}g"
  end
  # Return list of brands and capacity
  user_spool_option = gets.chomp.to_i
  spool_options[user_spool_option - 1]
end

def filament_remaining(selected_option)
  puts "What is the current weight of the spool in grams?"
  spool_weight = gets.chomp.to_i
  filament_remaining = spool_weight - selected_option[:spool_weight]
  puts "There is #{filament_remaining}g filament remaining"
end

selected_option = select_spool_option
filament_remaining(selected_option)