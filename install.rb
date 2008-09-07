require 'fileutils'


#RAILS_ROOT = File.join(File.dirname(__FILE__),'..','test')

#puts "installing"
PARTIAL_PATH = File.join(RAILS_ROOT ,'app' ,'views' , 'forms')
#puts File.dirname(__FILE__)
PLUGIN_ROOT = File.dirname(__FILE__)

FileUtils.mkdir_p PARTIAL_PATH

fields = ['_field.html.erb' ,'_field_with_error.html.erb']

fields.each do |field|
  FileUtils.copy(File.join(PLUGIN_ROOT,'resources',field),
    File.join(PARTIAL_PATH,field))
end

# FileUtils.copy(File.join(PLUGIN_ROOT,'resources',field),
#   File.join(PARTIAL_PATH,field))
# 
# FileUtils.copy(File.join(PLUGIN_ROOT,'resources',field_with_error),
#   File.join(PARTIAL_PATH,field_with_error))

watermark = 'jquery.watermark.js'
FileUtils.copy(File.join(PLUGIN_ROOT,'resources',watermark),
  File.join(RAILS_ROOT,'public','javascripts',watermark))
