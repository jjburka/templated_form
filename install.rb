require 'fileutils'

PARTIAL_PATH = File.join(RAILS_ROOT ,'app' ,'views' , 'forms')
PLUGIN_ROOT = File.dirname(__FILE__)

FileUtils.mkdir_p install_to
File.open(File.join(PARTIAL_PATH,'_field.html.erb'), 'w') do |f| 
  f.write(
<<-EOF
<p>
  <%= label %>
  <%= element %>
</p>    
EOF
  )
end

File.open(File.join(PARTIAL_PATH,'_field_with_error.html.erb'), 'w') do |f| 
  f.write(
<<-EOF
<p class="field_with_error">
  <%= label %>
  <%= element %>
  <span class="error_message">
    <%= error %>
  </span>
</p>   
EOF
  )
end

watermark = 'jquery.watermark.js'
File.cp(File.join(PLUGIN_ROOT,'resources',watermark),File.join(RAILS_ROOT,'public','javascripts',watermark))
