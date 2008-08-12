require 'fileutils'

install_to = File.join(RAILS_ROOT , 'views' , 'forms')


FileUtils.mkdir_p install_to
File.open(File.join(install_to,'_field.html.erb'), 'w') do |f| 
  f.write(
<<-EOF
<p>
  <%= label %>
  <%= element %>
</p>    
EOF
  )
end

File.open(File.join(install_to,'_field_with_error.html.erb'), 'w') do |f| 
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
