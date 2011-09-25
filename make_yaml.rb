require 'yaml'

LSL_VERSION = '1.23.4'
UPDATE_NOTICE = "LSL keywords updated #{Time.new.strftime("%d %b %Y")} for LSL #{LSL_VERSION} by http://adammarker.org/shill"

# remove quotes from beginning and end of the item.
def dequote(string)
  string.strip.gsub(/\A"(.*)"\z/m, '\1')
end

def sort_caseless(collection)
  collection.sort_by {|name| name.downcase}
end

def dechunk(collection)
  result = Hash.new
  collection.lines do |line|
    next if line.strip.size == 0
    next if line =~ /^\s*(#|\[)/  # skip comments and [headers]
    key, value = line.chomp.split(" ",2)
    
    # slightly different handling for CONSTANTS (start with uppercase) and events
    if key =~ /^[A-Z]/ then
      result[key] = {"synopsis" => value}
    else
      sig, help = value.split(':')
      result[key] = {"signature" => sig, "synopsis" => help}      
    end
  end
  result
end

def get_functions(functions_file)
  result = Hash.new
#               energy, sleep, dummy_func, name, return type, parameters, gods-only
#	  addFunction(10.f, 0.f, dummy_func, "llSay", NULL, "is");
  open(functions_file).each do | line |
    next if line =~ /^\s*\/\//        # skip comment lines
    next unless line =~ /addFunction\(\d/

    energy, sleep, _, func_name, return_type, parameters = line.split(/,\s*/, 6)
    result[dequote(func_name)] = {
        "energy" => energy,
        "sleep" => sleep,
        "returns" => dequote(return_type),
        "params" => dequote(parameters),
        }
  end
  result
end

def write_yaml(collection, file_name)
  File.open(file_name, 'w') do |out|
    out.puts("# " + UPDATE_NOTICE)
    out.puts(collection.to_yaml)
  end
end

## ---------- BEGIN MAIN ----------
kw_ini = File.read('LLsource/keywords.ini')
junk,events_chunk,constants_chunk,junk = kw_ini.split(/# events|# integer constants|# flow control keywords/)
constant_trove = dechunk(constants_chunk)
event_trove = dechunk(events_chunk)

function_trove = get_functions('LLsource/lscript_library.cpp')

keywords = {
  "events" => sort_caseless(event_trove.keys), 
  "functions" => sort_caseless(function_trove.keys), 
  "constants" => sort_caseless(constant_trove.keys)
  }
  
write_yaml(keywords, "keywords.yaml")
# write_yaml(function_trove.merge(event_trove), "signatures.yaml")
