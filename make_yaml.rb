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
  collection.each do |line|
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
# 	addFunction(new LLScriptLibraryFunction(10.f, 0.f, dummy_func, "llVecNorm", "v", "v", "vector llVecNorm(vector v)\nreturns the v normalized"));
  open(functions_file).each do | line |
    next if line =~ /^\s*\/\//        # skip comment lines
    next unless line =~ /new LLScriptLibraryFunction\(/

    energy, sleep, dummy, func_name, return_type, parameters, help_text = line.split(/,\s*/, 7)

    # clean up the varied syntax, notation, and general junk
    func_name = dequote(func_name)
    energy = energy.split('(').last
    # dequote the front, and separate sig and syn on newline
    junk, signature, synopsis = help_text.chomp.split(/"|\\n/,3)
    # Dequote or remove parens at end of function call.
    synopsis = synopsis.split(/"|\)\);/).first

    result[func_name] = {
        "energy" => energy,
        "sleep" => sleep,
        "returns" => dequote(return_type),
        "params" => dequote(parameters),
        "signature" => signature, 
        "synopsis" => synopsis
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
write_yaml(function_trove.merge(event_trove), "signatures.yaml")
