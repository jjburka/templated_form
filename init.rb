# Include hook code here

require 'templated_form_builder'
require 'templated_form'


ActionController::Base.send(:include,TemplatedForm)
ActionView::Base.send(:include,TemplatedForm)
