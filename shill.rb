require 'erb'
require 'rdoc'
require 'yaml'

LSL_VERSION = '3.0.3'  #TODO:  duplicated in files, ? set from signatures or module or...

rdoc_trove = { 'SHILL_UPDATE_NOTICE' =>
  "LSL keywords updated #{Time.new.strftime("%d %b %Y")} for LSL #{LSL_VERSION} by http://adammarker.org/shill" }

# Load raw materials of keywords and function/event signatures
keywords = YAML::load_file('keywords.yaml')
signatures = YAML::load_file('signatures.yaml')

# Fill the data stores needed for template resolution.
events, functions, constants = nil
keywords.each do |type, list|
  rdoc_trove[type] = list.collect {|keyword| {'name' => keyword} }

  case type
  when 'functions' then functions = list
  when 'constants' then constants = list
  when 'events'    then events = list
  end
end

# RDOC needs an extra special data store.
keywords.each do |type, list|
  rdoc_trove[type] = list.collect {|keyword| {'name' => keyword} }
end

# Ensure the erb templates don't muck with the core data structures.
events.freeze
functions.freeze
constants.freeze
keywords.freeze
signatures.freeze

# Pass the templates given on the command line through RDOC, then ERB to
# generate syntax files at the corresponding spot in the 'output' folder.
ARGV.each do |template_path|
  next if template_path =~ /shill.yaml/       # skip config files (TODO: name it config.yaml?)
  File.open(template_path) do |template_file|
    print "reading #{template_path}...  "

    syntax_path = template_path.sub('template/', 'site/')
    syntax_folder = File.dirname(syntax_path)
    Dir::mkdir(syntax_folder) unless File::exists? syntax_folder

    File.open(syntax_path, 'w') do |syntax_file|
      rdoc_result = ''
      page = TemplatePage.new(template_file.read)
      page.write_html_on(rdoc_result, rdoc_trove)

      syntax_file << ERB.new(rdoc_result, 0, "-").result
      puts "writing: #{syntax_path}"
    end  # write syntax file
  end  # read template file
end  # each template
